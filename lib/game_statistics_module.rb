module GameStatistics
  def highest_total_score
    high_game = games.max_by {|game| game.away_goals + game.home_goals}
    high_game.away_goals + high_game.home_goals
  end

  def lowest_total_score
    low_game = games.min_by {|game| game.away_goals + game.home_goals}
    low_game.away_goals + low_game.home_goals
  end

  def biggest_blowout
    difference = games.max_by{|game| (game.away_goals - game.home_goals).abs}
    (difference.away_goals - difference.home_goals).abs
  end

  def percentage_home_wins
    home_wins = games.count { |game| game.away_goals < game.home_goals}
    (home_wins.to_f / games.length).round(2)
  end

  def percentage_visitor_wins
    visitor_wins = games.count { |game| game.away_goals > game.home_goals}
    (visitor_wins.to_f / games.length).round(2)
  end

  def count_of_games_by_season
    games_by_season = {}
    games.each do |game|
      games_by_season[game.season] = games.count { |i| game.season == i.season}
    end
    games_by_season
  end

  def average_goals_per_game
    total_goals = 0
    total_games = []
    games.map {|game| total_goals += game.away_goals + game.home_goals}
    games.map {|game| total_games << game.game_id}
    (total_goals.to_f / total_games.length).round(2)
  end

  def average_goals_by_season
    goals_by_season = {}
    games.each do |game|
      goals_by_season[game.season] = games.map do |i|
        i.away_goals + i.home_goals if game.season == i.season
      end.compact.sum
    end
    array = [goals_by_season, count_of_games_by_season]
    keys = goals_by_season.keys
    Hash[keys.zip(array.map do |h|
      h.values_at(*keys)
    end.inject do |a, b|
       a.zip(b).map do |x, y|
        (x / y.to_f).round(2)
      end
    end)]
  end
end
