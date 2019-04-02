require 'minitest/autorun'
require 'minitest/pride'
require './lib/game_teams'

class GameTeamsTest < Minitest::Test
  def setup
    @game_teams_data = {
      "game_id" => "2012030221",
      "team_id" => "3",
      "HoA" => "away",
      "won" => "FALSE",
      "settled-in" => "OT",
      "head_coach" => "John Tortorella",
      "goals" => "2",
      "shots" => "35",
      "hits" => "44",
      "pim" => "8",
      "powerPlayOpportunities" => "3",
      "powerPlayGoals" => "0",
      "faceOffWinPercentage" => "44.8",
      "giveaways" => "17",
      "takeaways" => "7"
    }

    @game_teams = GameTeams.new(@game_teams_data)
  end

  def test_game_teams_class_exists
    assert_instance_of GameTeams, @game_teams
  end

end
