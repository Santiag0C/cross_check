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

  def test_lowest_scoring_visitor
    assert_equal "Stars", @stat_tracker.lowest_scoring_visitor
  end

  def test_lowest_scoring_home_team
    assert_equal "Devils", @stat_tracker.lowest_scoring_home_team
  end

  def test_highest_scoring_home_team
    assert_equal "Lightning", @stat_tracker.highest_scoring_home_team
  end

  def test_average_goals_per_games
    assert_equal 5.6, @stat_tracker.average_goals_per_game
  end

  def test_average_goals_by_season
    expected = {"20122013"=>4.65,
                "20132014"=>5.64,
                "20142015"=>5.75,
                "20152016"=>6.75,
                "20162017"=>6.86,
                "20172018"=>5.6}
    assert_equal expected, @stat_tracker.average_goals_by_season
  end
end
