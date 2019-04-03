require 'pry'
module GameStatistics
  def highest_total_score
    high_game = @games.max_by {|game| game.away_goals + game.home_goals}
    high_game.away_goals + high_game.home_goals
  end

  def lowest_total_score
      low_game = @games.min_by {|game| game.away_goals + game.home_goals}
      low_game.away_goals + low_game.home_goals
  end

  def biggest_blowout

  end
end
