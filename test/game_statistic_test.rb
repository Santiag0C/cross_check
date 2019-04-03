require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'
require 'pry'


class StatTrackerTest < Minitest::Test
  def setup
    game_path = './data/dummy_game.csv'
    team_path = './data/team_info.csv'
    game_teams_path = './data/dummy_game_teams.csv'

    @locations = {games: game_path,
                 teams: team_path,
                 game_teams: game_teams_path}
  end
  def test_highest_and_lowest_total_score
    stat_tracker = StatTracker.from_csv(@locations)
    assert_equal 6, stat_tracker.highest_total_score
    assert_equal 5, stat_tracker.lowest_total_score
  end
  def test_biggest_blowout
    stat_tracker = StatTracker.from_csv(@locations)
    assert_equal 3, stat_tracker.biggest_blowout
  end
end
