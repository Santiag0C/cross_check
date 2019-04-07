require 'pry'
module SeasonStatistics
  ###########################Logan's Helper Methods##################
  def coach_info(season)
    season = @game_teams.select{|game| season[0..3] == game.game_id[0..3]}
    coach_info = Hash.new{|results, coach| results[coach] = {wins: 0, total: 0}}
    season.each do |game|
      if game.won == 'true'
        coach_info[game.head_coach][:wins] += 1
      end
      coach_info[game.head_coach][:total] += 1
    end
    coach_info
  end
  ###################################################################
  def biggest_bust(season_id)
    #Name of the team with the biggest decrease between regular season and postseason win percentage.
    #return team name string
  end

  def biggest_surprise(season_id)
    #Name of the team with the biggest increase between regular season and postseason win percentage.
    #return team name string
  end

  def winningest_coach(season_id)
    coach_info(season_id).max_by {|k,v| v[:wins] / v[:total].to_f}[0]
  end

  def worst_coach(season_id)
    coach_info(season_id).min_by {|k,v| v[:wins] / v[:total].to_f}[0]
  end

  def most_accurate_team(season_id)
    #Name of the Team with the best ratio of shots to goals for the season
    #return team name string
  end

  def least_accurate_team(season_id)
    #Name of the Team with the worst ratio of shots to goals for the season
    #return team name string
  end

  def most_hits(season_id)
    #Name of the Team with the most hits in the season
    #return team name string
  end

  def fewest_hits(season_id)
    #Name of the Team with the fewest hits in the season
    #return team name string
  end

  def power_play_goal_percentage(season_id)
    #Percentage of goals that were power play goals for the season (rounded to the nearest 100th)
    #return percentage float
  end
end
