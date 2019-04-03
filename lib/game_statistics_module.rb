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
    goals = []
    difference = []
    @games.each do |game|
    goals << game.away_goals
    goals << game.home_goals
    goals.sort!
    difference << (goals[1] - goals[0])
    goals.pop(2)
      end
  difference.max
  end
end
