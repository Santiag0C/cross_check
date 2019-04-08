require 'pry'
module SeasonStatistics
  ###########################Helper Methods##################
  def coach_info_helper(season)
    season = @game_teams.select{|game| season[0..3] == game.game_id[0..3]}
    coach_info = Hash.new{|coach, results| coach[results] = {wins: 0, total: 0}}
    season.each do |game|
      if game.won == 'true'
        coach_info[game.head_coach][:wins] += 1
      end
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
        hits: 0,
        pim: 0,
        powerPlayOpportunities: 0,
        powerPlayGoals: 0,
        giveaways: 0,
        takeaways: 0}
    end #end of team_info hash
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
  ###################################################################
  def biggest_bust(season)
    #Name of the team with the biggest decrease between regular season and postseason win percentage.
    #return team name string
  end

  def biggest_surprise(season)
    #Name of the team with the biggest increase between regular season and postseason win percentage.
    #return team name string
  end

  def winningest_coach(season)
    coach_info_helper(season).max_by {|k,v| v[:wins] / v[:total].to_f}[0]
  end

  def worst_coach(season)
    coach_info_helper(season).min_by {|k,v| v[:wins] / v[:total].to_f}[0]
  end

  def most_accurate_team(season)
    #Name of the Team with the best ratio of shots to goals for the season
    #return team name string
    team = team_info_helper(season).max_by {|k,v| (v[:goals].to_f / v[:shots])}
    return_team_name(team[0])
  end

  def least_accurate_team(season)
    #Name of the Team with the worst ratio of shots to goals for the season
    #return team name string
    team = team_info_helper(season).min_by {|k,v| (v[:goals].to_f / v[:shots])}
    return_team_name(team[0])
  end

  def most_hits(season)
    #Name of the Team with the most hits in the season
    #return team name string
  end

  def fewest_hits(season)
    #Name of the Team with the fewest hits in the season
    #return team name string
  end

  def power_play_goal_percentage(season)
    power_play_goals = team_info_helper(season).sum {|k,v| v[:powerPlayGoals]}.to_f
    total_goals = team_info_helper(season).sum {|k,v| v[:goals]}.to_f
    (power_play_goals / total_goals).round(2)
  end
end
