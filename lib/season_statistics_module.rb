module SeasonStatistics
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
    return_team_name(highest[1])
  end

  def fewest_hits(season)
    fewest = hit_helper(season).invert.min
    return_team_name(fewest[1])
  end

  def power_play_goal_percentage(season)
    power_play_goals = team_info_helper(season).sum {|k,v| v[:powerPlayGoals]}.to_f
    total_goals = team_info_helper(season).sum {|k,v| v[:goals]}.to_f
    (power_play_goals / total_goals).round(2)
  end

  def season_gather
    @games.map {|game| game.season}.uniq
  end

  def hit_helper(input_season)
    hash = Hash.new{|h,k| h[k] = [] }
     season_gather.each do |season|
      @games.each do |game|
        hash[season].push(game.game_id) if game.season == season
      end
    end
    team_hits = Hash.new(0)
      hash[input_season].each do |game_i|
        @game_teams.each do |game|
        team_hits[game.team_id] += game.hits if game_i == game.game_id
      end
    end
  team_hits
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
        powerPlayGoals: 0}
    end
    season.each do |game|
      team_info[game.team_id][:goals] += game.goals
      team_info[game.team_id][:shots] += game.shots
      team_info[game.team_id][:powerPlayGoals] += game.power_play_goals
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
    end.inject do |reg_keys, playoff_keys|
      reg_keys.zip(playoff_keys).map do |reg_values, playoff_values|
        if reg_values[:total] != 0 && playoff_values[:total] != 0
          all_record = reg_values[:wins] + playoff_values[:wins]
          all_games  = reg_values[:total] + playoff_values[:total].to_f
          regular_season_record = reg_values[:wins] / reg_values[:total].to_f

          all_record / all_games - regular_season_record
        end
      end
    end)]
    difference
  end
end
