require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'

class SeasonStatisticsTest < Minitest::Test
  def setup
    game_path = './test/data/dummy_game.csv'
    team_path = './test/data/team_info.csv'
    game_teams_path = './test/data/iter5_dummy_game_teams.csv'

    @locations = {games: game_path,
                 teams: team_path,
                 game_teams: game_teams_path}

    @stat_tracker = StatTracker.from_csv(@locations)
  end

  def test_biggest_bust
    assert_equal 'Red Wings', @stat_tracker.biggest_bust('20122013')
  end

  def test_biggest_surprise
    assert_equal 'Bruins', @stat_tracker.biggest_surprise('20122013')
  end

  def test_winningest_coach
    assert_equal "Paul MacLean", @stat_tracker.winningest_coach("20122013")
  end

  def test_worst_coach
    assert_equal "Dan Bylsma", @stat_tracker.worst_coach("20122013")
  end

  def test_most_accurate_team
    assert_equal "Blues", @stat_tracker.most_accurate_team("20122013")
  end

  def test_least_accurate_team
    assert_equal "Penguins", @stat_tracker.least_accurate_team("20122013")
  end

  def test_most_hits
    assert_equal "Bruins", @stat_tracker.most_hits("20122013")
  end

  def test_fewest_hits
    assert_equal "Blackhawks", @stat_tracker.fewest_hits("20122013")
  end

  def test_power_play_goal_percentage
    assert_equal 0.18, @stat_tracker.power_play_goal_percentage("20122013")
  end
end
