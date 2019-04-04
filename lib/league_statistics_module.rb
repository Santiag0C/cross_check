require 'pry'
module LeagueStatistics
  def count_of_teams
    @teams.map { |team| team.team_name}.uniq.length
    #Realized the team_info.csv we have is different from the Rspec one.
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

end
