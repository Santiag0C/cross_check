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

  def highest_scoring_visitor
    teams.find {|team| goals_by_game(false).invert.max[1] == team.team_id}.team_name
  end

  def highest_scoring_home_team
    teams.find {|team| goals_by_game(true).invert.max[1] == team.team_id}.team_name
  end

  def lowest_scoring_visitor
    teams.find {|team| goals_by_game(false).invert.min[1] == team.team_id}.team_name
  end

  def lowest_scoring_home_team
    teams.find {|team| goals_by_game(true).invert.min[1] == team.team_id}.team_name
  end

  def winningest_team
    return_team_name(team_wins.max_by {|team| team[1].to_f / games_per_team[team[0]]}[0])
  end

  def best_fans
    return_team_name(group_by_teams.max_by do |team|
      home_record = team_home_wins[team[0]].to_f / home_games_per_team[team[0]]
      away_record = team_away_wins[team[0]].to_f / away_games_per_team[team[0]]
      home_record - away_record
    end[0])
  end

  def worst_fans
    group_by_teams.map do |team|
      home_record = team_home_wins[team[0]].to_f / home_games_per_team[team[0]]
      away_record = team_away_wins[team[0]].to_f / away_games_per_team[team[0]]
      return_team_name(team[0]) if home_record < away_record
    end.compact
  end
end
