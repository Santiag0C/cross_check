require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'
require 'pry'

class TeamStatisticsTest < Minitest::Test
  def setup
    game_path = './data/dummy_game.csv'
    team_path = './data/team_info.csv'
    game_teams_path = './data/dummy_game_teams.csv'

    @locations = {games: game_path,
                 teams: team_path,
                 game_teams: game_teams_path}

    @stat_tracker = StatTracker.from_csv(@locations)
  end


  ########## James Iteration 4 Team Tests ########
  def test_biggest_team_blowout
    assert_equal 1, @stat_tracker.biggest_team_blowout("3")
  end

  def test_worst_loss
    assert_equal 3, @stat_tracker.worst_loss("3")
  end

  def test_head_to_head
    expected = {
      "Penguins"=>0.0,
      "Stars"=>1.0,
      "Flyers"=>0.0,
      "Hurricanes"=>1.0
    }
    assert_equal expected, @stat_tracker.head_to_head("1")
  end
  ########## James Iteration 4 Team Tests ########

end
