require 'pry'
module TeamStatistics

  ########### James Iteration 4 Team Statistics #################
  def biggest_team_blowout(team_id)
    @games.map do |game|
      if game.away_team_id == team_id
        game.away_goals - game.home_goals
      elsif game.home_team_id == team_id
        game.home_goals - game.away_goals
      end
    end.compact.max
  end

  def worst_loss(team_id)
    @games.map do |game|
      if game.away_team_id == team_id
        game.away_goals - game.home_goals
      elsif game.home_team_id == team_id
        game.home_goals - game.away_goals
      end
    end.compact.min.abs
  end

  def head_to_head
    # Record (as a hash - win/loss) against all opponents with the opponents’ names as keys and the win percentage against that opponent as a value.	Hash

  end

  def seasonal_summary
    # For each season that the team has played, a hash that has two keys (:regular_season and :postseason), that each point to a hash with the following keys: :win_percentage, :total_goals_scored, :total_goals_against, :average_goals_scored, :average_goals_against.	Hash
  end
    ########### James Iteration 4 Team Statistics #################

end
