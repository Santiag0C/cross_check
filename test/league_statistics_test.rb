require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'

class LeagueStatisticsTest < Minitest::Test
  def setup
    game_path = './test/data/dummy_game.csv'
    team_path = './test/data/team_info.csv'
    game_teams_path = './test/data/dummy_game_teams.csv'

    @locations = {games: game_path,
                 teams: team_path,
                 game_teams: game_teams_path}

    @stat_tracker = StatTracker.from_csv(@locations)
  end

  def test_count_of_teams_in_league
    assert_equal 32, @stat_tracker.count_of_teams
  end

  def test_best_offense_in_league
    assert_equal "Islanders", @stat_tracker.best_offense
  end

  def test_worst_offense_in_league
    assert_equal "Stars", @stat_tracker.worst_offense
  end

  def test_best_defense_in_league
    assert_equal "Bruins", @stat_tracker.best_defense
  end

  def test_worst_defense_in_league
    assert_equal "Canucks", @stat_tracker.worst_defense
  end

  def test_winningest_team
    assert_equal "Bruins", @stat_tracker.winningest_team
  end

  def test_best_fans
    assert_equal "Rangers", @stat_tracker.best_fans
  end

  def test_worst_fans
    assert_equal ["Senators"], @stat_tracker.worst_fans
  end

  # Helpers
  def test_group_by_teams
    assert_equal 7, @stat_tracker.group_by_teams.length
  end

  def test_return_team_name
    assert_equal "Devils", @stat_tracker.return_team_name('1')
  end

end
