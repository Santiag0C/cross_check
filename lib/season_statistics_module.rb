require 'pry'
module SeasonStatistics

  

  def season_gather #helper
    seasons =[]
      @games.each do |game|
        seasons << game.season
      end
    seasons.uniq
  end

  def hit_helper(season)#helper
    hash = Hash.new{|h,k| h[k] = [] }
     season_gather.each do |season|
      @games.each do |game|
        if game.season == season
          hash[season].push(game.game_id)
        end
      end
    end
    team_hits = Hash.new(0)
      hash[season].each do |game_i|
        @game_teams.each do |game|
        if game_i == game.game_id
          team_hits[game.team_id] += game.hits
        end
      end
    end
  team_hits
  end

  def name_finder(something) #helper
    @teams.each do |team|
      if team.team_id == something[1]
        return team.team_name
      end
    end
  end
 
  def season_helper(season, season_type)
    season = @game_teams.select{|game| season[0..3] == game.game_id[0..3]}
    season_hash = Hash.new{|team, results| team[results] = {wins: 0, total: 0}}
    season.each do |game|
      if game.game_id[5] == season_type
        season_hash[game.team_id][:wins] += 1 if game.won == 'true'
        season_hash[game.team_id][:total] += 1
      end
    end
    season_hash
  end

  def coach_info_helper(season)
    season = @game_teams.select{|game| season[0..3] == game.game_id[0..3]}
    coach_info = Hash.new{|coach, results| coach[results] = {wins: 0, total: 0}}
    season.each do |game|
      coach_info[game.head_coach][:wins] += 1 if game.won == 'true'
      coach_info[game.head_coach][:total] += 1
    end
    coach_info
  end

  def team_info_helper(season)
    season = @game_teams.select{|game| season[0..3] == game.game_id[0..3]}
    team_info = Hash.new do |results, team|
      results[team] = {
        goals: 0,
        shots: 0,
        hits:  0,
        pim:   0,
        powerPlayOpportunities: 0,
        powerPlayGoals: 0,
        giveaways: 0,
        takeaways: 0}
    end
    season.each do |game|
      team_info[game.team_id][:goals] += game.goals
      team_info[game.team_id][:shots] += game.shots
      team_info[game.team_id][:hits] += game.hits
      team_info[game.team_id][:pim] += game.pim
      team_info[game.team_id][:powerPlayOpportunities] += game.power_play_opportunities
      team_info[game.team_id][:powerPlayGoals] += game.power_play_goals
      team_info[game.team_id][:giveaways] += game.giveaways
      team_info[game.team_id][:takeaways] += game.takeaways
    end
    team_info
  end

  def season_type_difference(season)
    reg = season_helper(season, "2")
    playoff = season_helper(season, "3")
    array = [reg, playoff]
    keys = playoff.keys
    difference = Hash[keys.zip(array.map do |reg_hash|
      reg_hash.values_at(*keys)
    end.inject do |a, b|
      a.zip(b).map do |x, y|
        if x[:total] != 0 && y[:total] != 0
          (((x[:wins] + y[:wins]) / (x[:total] + y[:total].to_f)) - (x[:wins] / x[:total].to_f))
        end
      end
    end)]
    difference
  end

  def biggest_bust(season)
    difference = season_type_difference(season)
    id = difference.compact.min_by {|k,v| v}
    return_team_name(id[0])
  end

  def biggest_surprise(season)
    difference = season_type_difference(season)
    id = difference.compact.max_by {|k,v| v}
    return_team_name(id[0])
  end

  def winningest_coach(season)
    coach_info_helper(season).max_by {|k,v| v[:wins] / v[:total].to_f}[0]
  end

  def worst_coach(season)
    coach_info_helper(season).min_by {|k,v| v[:wins] / v[:total].to_f}[0]
  end

  def most_accurate_team(season)
    team = team_info_helper(season).max_by {|k,v| (v[:goals].to_f / v[:shots])}
    return_team_name(team[0])
  end

  def least_accurate_team(season)
    team = team_info_helper(season).min_by {|k,v| (v[:goals].to_f / v[:shots])}
    return_team_name(team[0])
  end

  def most_hits(season)
    highest = hit_helper(season).invert.max
    name_finder(highest)
  end

  def fewest_hits(season)
    fewest = hit_helper(season).invert.min
    name_finder(fewest)
  end

  def power_play_goal_percentage(season)
    power_play_goals = team_info_helper(season).sum {|k,v| v[:powerPlayGoals]}.to_f
    total_goals = team_info_helper(season).sum {|k,v| v[:goals]}.to_f
    (power_play_goals / total_goals).round(2)
  end
end
