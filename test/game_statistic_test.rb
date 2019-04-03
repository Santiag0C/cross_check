require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'
require 'pry'


class GameStatisticsTest < Minitest::Test
  def test_highest_total_score
    game_path = './data/dummy_game.csv'
    locations = {games: game_path}
    binding.pry
    stat_tracker = StatTracker.from_csv(locations[:games])
    assert_equal 6, stat_tracker.highest_total_score
  end
end
