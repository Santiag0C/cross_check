module LeagueStatistics
  def count_of_teams
    @teams.group_by { |team| team.team_id}.length
  end

  def goals_per_game_for
    goals_for = Hash.new(0)
    game_count = Hash.new(0)
    averaged = Hash.new(0)
    @games.each do |game|
      game_count[game.home_team_id] += 1
      game_count[game.away_team_id] += 1

      goals_for[game.home_team_id] += game.home_goals
      goals_for[game.away_team_id] += game.away_goals
    end

    goals_for.keys.each do |key|
      averaged[key] = goals_for[key].to_f/game_count[key]
    end
    averaged
  end

  def goals_per_game_against
    goals_for = Hash.new(0)
    game_count = Hash.new(0)
    averaged = Hash.new(0)
    @games.each do |game|
      game_count[game.home_team_id] += 1
      game_count[game.away_team_id] += 1

      goals_for[game.home_team_id] += game.away_goals
      goals_for[game.away_team_id] += game.home_goals
    end

    goals_for.keys.each do |key|
      averaged[key] = goals_for[key].to_f/game_count[key]
    end
    averaged
  end

  def best_offense
    return_team_name(goals_per_game_for.max_by{ |k,v| v}[0])
  end

  def worst_offense
    return_team_name(goals_per_game_for.min_by{ |k,v| v}[0])
  end

  def best_defense
    return_team_name(goals_per_game_against.min_by{ |k,v| v}[0])
  end

  def worst_defense
    return_team_name(goals_per_game_against.max_by{ |k,v| v}[0])
  end

  ###################LOGAN'S HELPER METHODS#############################
  # creates hash with key is team_id and value is array of game_teams obj
  def group_by_teams
    @game_teams.group_by {|obj| obj.team_id}
  end

  # give method team id and it returns team name
  def return_team_name(team_id)
    teams.find {|team| team_id == team.team_id}.team_name
  end

  # creates hash with key is team id and value is number of games
  def games_per_team
    games_per_team = Hash.new {|h,k| h[k] = 0}
    group_by_teams.each {|team| games_per_team[team[0]] += team[1].count}
    games_per_team
  end

  # creates hash with key is team id and value is number of home games
  def home_games_per_team
    home_games_per_team = Hash.new {|h,k| h[k] = 0}
    group_by_teams.each do |team|
      team[1].each do |i|
        home_games_per_team[team[0]] += team[1].count if i.hoa == "home"
      end
    end
    home_games_per_team
  end

  # creates hash with key is team id and value is number of away games
  def away_games_per_team
    away_games_per_team = Hash.new {|h,k| h[k] = 0}
    group_by_teams.each do |team|
      team[1].each do |i|
        away_games_per_team[team[0]] += team[1].count if i.hoa == "away"
      end
    end
    away_games_per_team
  end

  # fills hash with team_id as key and amount of games won as value
  def team_wins
    team_wins = Hash.new {|h,k| h[k] = 0}
    group_by_teams.each do |team|
      team[1].each do |game|
        team_wins[team[0]] += 1 if game.won == 'true'
      end
    end
    team_wins
  end

  # fills hash with team_id as key and amount of home games won as value
  def home_wins_per_team
    home_wins_per_team = Hash.new {|h,k| h[k] = 0}
    group_by_teams.each do |team|
      team[1].each do |game|
        home_wins_per_team[team[0]] += 1 if game.won == 'true' && game.hoa == 'home'
      end
    end
    home_wins_per_team
  end

  # fills hash with team_id as key and amount of home games won as value
  def away_wins_per_team
    away_wins_per_team = Hash.new {|h,k| h[k] = 0}
    group_by_teams.each do |team|
      team[1].each do |game|
        away_wins_per_team[team[0]] += 1 if game.won == 'true' && game.hoa == 'away'
      end
    end
    away_wins_per_team
  end
  ######################################################################

  def winningest_team
    id = team_wins.max_by {|team| team[1].to_f / games_per_team[team[0]]}[0]
    return_team_name(id)
  end

  def best_fans
    id = group_by_teams.max_by do |team|
      home_wins_per_team[team[0]].to_f / home_games_per_team[team[0]] - away_wins_per_team[team[0]].to_f / away_games_per_team[team[0]]
    end[0]
    return_team_name(id)
  end

  def worst_fans
    worst_fans = []
    group_by_teams.each do |team|
      if home_wins_per_team[team[0]].to_f / home_games_per_team[team[0]] < away_wins_per_team[team[0]].to_f / away_games_per_team[team[0]]
        worst_fans << return_team_name(team[0])
      end
    end
    worst_fans
  end



end
