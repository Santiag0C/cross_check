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

  def test_team_info
    expected = {
      "team_id" => "18",
      "franchise_id" => "34",
      "short_name" => "Nashville",
      "team_name" => "Predators",
      "abbreviation" => "NSH",
      "link" => "/api/v1/teams/18"
    }
    assert_equal expected, @stat_tracker.team_info("18")
  end

  def test_best_season
    assert_equal "20132014", @stat_tracker.best_season("3")
  end

  def test_worst_season
    assert_equal "20122013", @stat_tracker.worst_season("3")
  end

  def test_average_win_percentage
    assert_equal 0.2, @stat_tracker.average_win_percentage("3")
  end

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

  def test_favorite_opponent
    assert_equal "Stars", @stat_tracker.favorite_opponent("1")
  end

  def test_rival
    assert_equal "Jets", @stat_tracker.rival("3")
  end

  def test_most_goals_scored
    assert_equal 4, @stat_tracker.most_goals_scored("3")
  end

  def test_fewest_goals_scored
    assert_equal 0, @stat_tracker.fewest_goals_scored("3")
  end
end
