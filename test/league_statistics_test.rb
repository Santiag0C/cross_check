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

  def test_group_by_teams
    assert_equal 7, @stat_tracker.group_by_teams.length
  end

  def test_return_team_name
    assert_equal "Devils", @stat_tracker.return_team_name('1')
  end

  def test_winningest_team
    assert_equal "Senators", @stat_tracker.winningest_team
  end

  def test_count_of_teams_in_league
    assert_equal 32, @stat_tracker.count_of_teams
  end

  def test_best_offense_in_league
    assert_equal "Senators", @stat_tracker.best_offense
  end

  def test_worst_offense_in_league
    assert_equal "Penguins", @stat_tracker.worst_offense
  end

  def test_best_fans
    skip
    # Need to put in more data in dummy file
    assert_equal 1, @stat_tracker.best_fans
  end

  def test_worst_fans
    assert_equal [], @stat_tracker.worst_fans
  end

end
