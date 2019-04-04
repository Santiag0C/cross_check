require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'
require 'pry'

class LeagueStatisticsTest < Minitest::Test
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

    assert_equal 10, @stat_tracker.biggest_team_blowout("3")
  end
  ########## James Iteration 4 Team Tests ########

end
