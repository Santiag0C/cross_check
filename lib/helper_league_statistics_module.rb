module HelperLeagueStatistics
  def goals_per_game_for
    goals_for = Hash.new(0)
    game_count = Hash.new(0)
    averaged = Hash.new(0)
    games.each do |game|
      game_count[game.home_team_id] += 1
      game_count[game.away_team_id] += 1
      goals_for[game.home_team_id]  += game.home_goals
      goals_for[game.away_team_id]  += game.away_goals
    end
    goals_for.keys.each {|key| averaged[key] = goals_for[key].to_f/game_count[key]}
    averaged
  end

  def goals_per_game_against
    goals_against = Hash.new(0); game_count = Hash.new(0); averaged = Hash.new(0)
    games.each do |game|
      game_count[game.home_team_id]    += 1
      game_count[game.away_team_id]    += 1
      goals_against[game.home_team_id] += game.away_goals
      goals_against[game.away_team_id] += game.home_goals
    end
    goals_against.keys.each do |key|
      averaged[key] = goals_against[key].to_f/game_count[key]
    end
    averaged
  end

  def group_by_teams
    game_teams.group_by {|obj| obj.team_id}
  end

  def return_team_name(team_id)
    teams.find {|team| team_id == team.team_id}.team_name
  end

  def games_per_team
    games_per_team = Hash.new(0)
    group_by_teams.each {|team| games_per_team[team[0]] += team[1].count}
    games_per_team
  end

  def home_games_per_team
    home_games = Hash.new(0)
    group_by_teams.each do |team|
      team[1].each {|i| home_games[team[0]] += team[1].count if i.hoa == "home"}
    end
    home_games
  end

  def away_games_per_team
    away_games = Hash.new(0)
    group_by_teams.each do |team|
      team[1].each {|i| away_games[team[0]] += team[1].count if i.hoa == "away"}
    end
    away_games
  end

  def team_wins
    team_wins = Hash.new(0)
    group_by_teams.each do |team|
      team[1].each {|game| team_wins[team[0]] += 1 if game.won == 'true'}
    end
    team_wins
  end

  def team_home_wins
    team_home_wins = Hash.new(0)
    group_by_teams.each do |team|
      team[1].each do |game|
        team_home_wins[team[0]] += 1 if game.won == 'true' && game.hoa == 'home'
      end
    end
    team_home_wins
  end

  def team_away_wins
    team_away_wins = Hash.new(0)
    group_by_teams.each do |team|
      team[1].each do |game|
        team_away_wins[team[0]] += 1 if game.won == 'true' && game.hoa == 'away'
      end
    end
    team_away_wins
  end

  def goals_by_game(bool)
    away_id = []
    hash = Hash.new{|h,k| h[k] = []}
    goals_by_game = {}
    games.each do |game|
      away_id << game.away_team_id if bool == false
      away_id << game.home_team_id
    end
    away_id.uniq.each do |aw_id|
      games.each do |game|
        hash[aw_id] << game.away_goals if aw_id == game.away_team_id && bool == false
        hash[aw_id] << game.home_goals if aw_id == game.home_team_id && bool == true
      end
    end
    hash.keys.each {|key| goals_by_game[key] = hash[key].sum.to_f/hash[key].count}
    goals_by_game
  end
end
