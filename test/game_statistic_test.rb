require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'
require 'pry'


class GameStatisticsTest < Minitest::Test
  def setup
    game_path = './data/dummy_game.csv'
    team_path = './data/team_info.csv'
    game_teams_path = './data/dummy_game_teams.csv'

    @locations = {games: game_path,
                 teams: team_path,
                 game_teams: game_teams_path}

    @stat_tracker = StatTracker.from_csv(@locations)
  end

  def test_highest_and_lowest_total_score
    assert_equal 12, @stat_tracker.highest_total_score
    assert_equal 1, @stat_tracker.lowest_total_score
  end

  def test_biggest_blowout
    assert_equal 5, @stat_tracker.biggest_blowout
  end

  def test_percentage_home_wins
    assert_equal 0.49, @stat_tracker.percentage_home_wins
  end

  def test_percentage_visitor_wins
    assert_equal 0.51, @stat_tracker.percentage_visitor_wins
  end

  def test_count_of_games_by_season
    expected = {"20122013"=>20,
                "20132014"=>11,
                "20142015"=>4,
                "20152016"=>8,
                "20162017"=>7,
                "20172018"=>5}
    assert_equal expected, @stat_tracker.count_of_games_by_season
  end
  def test_highest_scoring_visitor
    assert_equal "Oilers", @stat_tracker.highest_scoring_visitor
  end
end
