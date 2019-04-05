require 'pry'
module TeamStatistics

  ########### James Iteration 4 Team Statistics #################
  def biggest_team_blowout(team_id)
    # Biggest difference between team goals and opponent goals for a win for the given team.	Integer

    # Iterate through @games.

#Max_by::::::
    # If away_team_id == argument_team_id,
    #   => biggest_away_blowout = max_by(away_goals - home_goals)

    # If home_team_id == argument_team_id,
    #   => biggest_home_blowout = max_by(home_goals - away_goals)
#     :::::::::::::::

    @games.each do |game|
      blowout_array = []

      if game.away_team_id == team_id
        blowout_array

      binding.pry
      end

    end




  end

  def worst_loss
    # Biggest difference between team goals and opponent goals for a loss for the given team.	Integer
  end

  def head_to_head
    # Record (as a hash - win/loss) against all opponents with the opponents’ names as keys and the win percentage against that opponent as a value.	Hash

  end

  def seasonal_summary
    # For each season that the team has played, a hash that has two keys (:regular_season and :postseason), that each point to a hash with the following keys: :win_percentage, :total_goals_scored, :total_goals_against, :average_goals_scored, :average_goals_against.	Hash
  end
    ########### James Iteration 4 Team Statistics #################

end
