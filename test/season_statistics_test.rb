require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'
require 'pry'

class SeasonStatisticsTest < Minitest::Test
  def setup
    game_path = './data/dummy_game.csv'
    team_path = './data/team_info.csv'
    game_teams_path = './data/dummy_game_teams.csv'

    @locations = {games: game_path,
                 teams: team_path,
                 game_teams: game_teams_path}

    @stat_tracker = StatTracker.from_csv(@locations)
  end

  def test_biggest_bust

  end

  def test_biggest_surprise

  end

  def test_winningest_coach
    assert_equal "Paul MacLean", @stat_tracker.winningest_coach("20122013")
  end

  def test_worst_coach
    assert_equal "Dan Bylsma", @stat_tracker.worst_coach("20122013")
  end

  def test_most_accurate_team

  end

  def test_least_accurate_team

  end

  def test_most_hits

  end

  def test_fewest_hits

  end

  def test_power_play_goal_percentage

  end
end
