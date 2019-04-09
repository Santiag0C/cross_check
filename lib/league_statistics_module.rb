module LeagueStatistics
  def count_of_teams
    @teams.group_by {|team| team.team_id}.length
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

  def highest_scoring_visitor #uses gg helper
    teams.find {|team| gg(false).invert.max[1] == team.team_id}.team_name
  end

  def highest_scoring_home_team #uses gg helper
    teams.find {|team| gg(true).invert.max[1] == team.team_id}.team_name
  end

  def lowest_scoring_visitor #uses gg helper
    teams.find {|team| gg(false).invert.min[1] == team.team_id}.team_name
  end

  def lowest_scoring_home_team #uses gg helper
    teams.find {|team| gg(true).invert.min[1] == team.team_id}.team_name
  end

  def gg(x)
    away_id = []; hash = Hash.new{|h,k| h[k] = []}; hashh = {}
    games.each {|game| away_id << game.away_team_id if x == false; away_id << game.home_team_id}
    away_id.uniq.each do |aw_id|
      games.each do |game|
        hash[aw_id] << game.away_goals if aw_id == game.away_team_id && x == false
        hash[aw_id] << game.home_goals if aw_id == game.home_team_id && x == true
      end
    end
    hash.keys.each {|key| hashh[key] = hash[key].sum.to_f/hash[key].count}
    hashh
  end

  def winningest_team
    return_team_name(team_wins.max_by {|team| team[1].to_f / games_per_team[team[0]]}[0])
  end

  def best_fans
    return_team_name(group_by_teams.max_by do |team|
      team_home_wins[team[0]].to_f / home_games_per_team[team[0]] -
      team_away_wins[team[0]].to_f / away_games_per_team[team[0]]
    end[0])
  end

  def worst_fans
    group_by_teams.map do |team|
      home_wins = team_home_wins[team[0]].to_f / home_games_per_team[team[0]]
      away_wins = team_away_wins[team[0]].to_f / away_games_per_team[team[0]]
      return_team_name(team[0]) if home_wins < away_wins
    end.compact
  end

  def goals_per_game_for
    goals_for = Hash.new(0); game_count = Hash.new(0); averaged = Hash.new(0)
    games.each do |game|
      game_count[game.home_team_id] += 1; game_count[game.away_team_id] += 1
      goals_for[game.home_team_id] += game.home_goals
      goals_for[game.away_team_id] += game.away_goals
    end
    goals_for.keys.each {|key| averaged[key] = goals_for[key].to_f/game_count[key]}
    averaged
  end

  def goals_per_game_against
    goals_against = Hash.new(0); game_count = Hash.new(0); averaged = Hash.new(0)
    games.each do |game|
      game_count[game.home_team_id] += 1; game_count[game.away_team_id] += 1
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
    group_by_teams.each {|team| team[1].each {|i| home_games[team[0]] += team[1].count if i.hoa == "home"}}
    home_games
  end

  def away_games_per_team
    away_games = Hash.new(0)
    group_by_teams.each do |team|
      team[1].each { |i| away_games[team[0]] += team[1].count if i.hoa == "away"}
    end
    away_games
  end


  def team_wins
    team_wins = Hash.new(0)
    group_by_teams.each do |team|
      team[1].each { |game| team_wins[team[0]] += 1 if game.won == 'true'}
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
end
