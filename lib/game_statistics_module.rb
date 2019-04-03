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

  def percentage_home_wins
    games_won = 0
    @games.each do |game|
      if game.home_goals > game.away_goals
        games_won += 1
      end
    end
    percentage = (games_won.to_f/@games.count) * 100
    percentage.round(2)
  end

  def percentage_visitor_wins
    100.00 - percentage_home_wins
  end

  def count_of_games_by_season
    hash = {}
    @games.each do |game|
      if hash.key?(game.season) == false
        hash[game.season] = 1
      elsif hash.key?(game.season) == true
        hash[game.season] += 1
      end
    end
    hash
  end

  def average_goals_per_game

  end
end
