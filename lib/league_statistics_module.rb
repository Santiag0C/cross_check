require 'pry'
module LeagueStatistics
  def count_of_teams
    @teams.map { |team| team.team_name}.uniq.length
  end

  def best_offense
# create an array of 32 team names
    team_names = @teams.map do |team|
      team.team_name
    end.uniq
    binding.pry

# create hash of "team_name" => franchise_id

# iterate through team_names and sum up all


# Name of the team with the highest average number of goals scored per game across all seasons.





### team_names.each do |team|
###
  end

  def worst_offense
  end

end
