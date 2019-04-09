module LeagueStatistics
  def count_of_teams
    @teams.group_by { |team| team.team_id}.length
  end

  def best_offense
    teams_and_ids = {}

    team_names = @teams.map do |team|
      team.team_name
    end.uniq

    team_names.each do |team|
      teams_and_ids[team] = @teams.map { |t| t.team_id if t.team_name == team }.compact
    end

    ids_and_goals_per_game = {}
    teams_and_ids.values.each do |id|
      if @game_teams.map { |game_team| game_team.goals if id.include?(game_team.team_id)}.compact.length != 0
        ids_and_goals_per_game[id] = @game_teams.map { |game_team| game_team.goals if id.include?(game_team.team_id)}.compact.sum.to_f / @game_teams.map { |game_team| game_team.goals if id.include?(game_team.team_id)}.compact.length
      end
    end

    teams_and_ids.key(ids_and_goals_per_game.max_by{ |k,v| v}[0])
    # Need to account for variable team_id (coyotes)
    # Needs major refactoring
  end

  def worst_offense
    teams_and_ids = {}

    team_names = @teams.map do |team|
      team.team_name
    end.uniq

    team_names.each do |team|
      teams_and_ids[team] = @teams.map { |t| t.team_id if t.team_name == team }.compact
    end

    ids_and_goals_per_game = {}
    teams_and_ids.values.each do |id|
      if @game_teams.map { |game_team| game_team.goals if id.include?(game_team.team_id)}.compact.length != 0
        ids_and_goals_per_game[id] = @game_teams.map { |game_team| game_team.goals if id.include?(game_team.team_id)}.compact.sum.to_f / @game_teams.map { |game_team| game_team.goals if id.include?(game_team.team_id)}.compact.length
      end
    end

    teams_and_ids.key(ids_and_goals_per_game.min_by{ |k,v| v}[0])
    # Need to account for variable team_id (coyotes)
    # Needs major refactoring
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
  def wins_per_team
    wins_per_team = Hash.new {|h,k| h[k] = 0}
    home_wins_per_team = Hash.new {|h,k| h[k] = 0}
    group_by_teams.each do |team|
      team[1].each do |game|
        wins_per_team[team[0]] += 1 if game.won == 'true'
      end
    end
    wins_per_team
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
    id = wins_per_team.max_by {|team| team[1].to_f / games_per_team[team[0]]}[0]
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
        worst_fans << team
      end
    end
    worst_fans
  end
end
