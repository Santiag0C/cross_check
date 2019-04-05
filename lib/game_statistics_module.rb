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
    home_wins = @games.count { |game| game.away_goals < game.home_goals}
    (home_wins.to_f / @games.length).round(2)
  end

  def percentage_visitor_wins
    visitor_wins = @games.count { |game| game.away_goals > game.home_goals}
    (visitor_wins.to_f / @games.length).round(2)
  end

  def count_of_games_by_season
    games_by_season = {}
    @games.each do |game|
      games_by_season[game.season] = @games.count { |i| game.season == i.season}
    end
    games_by_season
  end

  def average_goals_per_game
    total_goals = 0
    total_games = []
    @games.map {|game| total_goals += game.away_goals + game.home_goals}
    @games.map {|game| total_games << game.game_id}
    (total_goals.to_f / total_games.length).round(2)
  end

  def highest_scoring_visitor #uses gg helper
      id = gg(false).invert.max[1]
    @teams.find do |team|
      if id == team.team_id
        return team.team_name
      end
    end
  end

  def highest_scoring_home_team #uses gg helper
      id = gg(true).invert.max[1]
    @teams.find do |team|
      if id == team.team_id
        return team.team_name
      end
    end
  end

  def lowest_scoring_visitor #uses gg helper
      id = gg(false).invert.min[1]
    @teams.find do |team|
      if id == team.team_id
        return team.team_name
      end
    end
  end

  def lowest_scoring_home_team #uses gg helper
      id = gg(true).invert.min[1]
    @teams.find do |team|
      if id == team.team_id
        return team.team_name
      end
    end
  end

  def gg(x)
    away_id = []
    @games.each do |game|
      if x == false
        away_id << game.away_team_id
      else
        away_id << game.home_team_id
        end
      end
    away_id.uniq!
    hash = Hash.new{|h,k| h[k] = [] }
    away_id.each do |aw_id|
      @games.each do |game|
        if x == false
          if aw_id == game.away_team_id
            hash[aw_id].push(game.away_goals)
          end
        else
          if aw_id == game.home_team_id
            hash[aw_id].push(game.home_goals)
          end
        end
      end
    end
    hashh = {}
    items_in_arr = []
    hash.keys.each do |key|
      items_in_arr = hash[key].count
      sumgol = hash[key].sum
      av = sumgol.to_f/items_in_arr
      hashh[key] = av
    end
    hashh
  end
end
