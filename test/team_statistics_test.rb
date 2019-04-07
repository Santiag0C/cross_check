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

  ########## James Iteration 4 Team Tests ########
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

  def test_seasonal_summary


    expected = {
    "20162017" => {
      postseason: {
        :win_percentage=>0.64,
        :total_goals_scored=>60,
        :total_goals_against=>48,
        :average_goals_scored=>2.73,
        :average_goals_against=>2.18},
        :regular_season => {
          :win_percentage=>0.5,
          :total_goals_scored=>240,
          :total_goals_against=>224,
          :average_goals_scored=>2.93,
          :average_goals_against=>2.73
        }
      },
      "20172018" => {
        postseason: {
          :win_percentage=>0.54,
          :total_goals_scored=>41,
          :total_goals_against=>42,
          :average_goals_scored=>3.15,
          :average_goals_against=>3.23
        },
        :regular_season=>
        {:win_percentage=>0.65,
          :total_goals_scored=>267,
          :total_goals_against=>211,
          :average_goals_scored=>3.26,
          :average_goals_against=>2.57
        }
      },
      "20132014" => {
        postseason: {
          :win_percentage=>0.0,
          :total_goals_scored=>0,
          :total_goals_against=>0,
          :average_goals_scored=>0.0,
          :average_goals_against=>0.0
        },
        :regular_season=>
        {
          :win_percentage=>0.46,
          :total_goals_scored=>216,
          :total_goals_against=>242,
          :average_goals_scored=>2.63,
          :average_goals_against=>2.95
        }
      },
      "20122013" => {
        postseason: {
          :win_percentage=>0.0,
          :total_goals_scored=>0,
          :total_goals_against=>0,
          :average_goals_scored=>0.0,
          :average_goals_against=>0.0
        },
        :regular_season=>
        {
          :win_percentage=>0.33,
          :total_goals_scored=>111,
          :total_goals_against=>139,
          :average_goals_scored=>2.31,
          :average_goals_against=>2.9
        }
      },
      "20142015" => {
        postseason: {
          :win_percentage=>0.33,
          :total_goals_scored=>21,
          :total_goals_against=>19,
          :average_goals_scored=>3.5,
          :average_goals_against=>3.17
        },
        :regular_season=>
        {
          :win_percentage=>0.57,
          :total_goals_scored=>232,
          :total_goals_against=>208,
          :average_goals_scored=>2.83,
          :average_goals_against=>2.54
        }
      },
      "20152016" => {
        postseason: {
          :win_percentage=>0.5,
          :total_goals_scored=>31,
          :total_goals_against=>43,
          :average_goals_scored=>2.21,
          :average_goals_against=>3.07
        },
        :regular_season=>
        {
          :win_percentage=>0.5,
          :total_goals_scored=>228,
          :total_goals_against=>215,
          :average_goals_scored=>2.78,
          :average_goals_against=>2.62
        }
      }
    }
    assert_equal expected, @stat_tracker.seasonal_summary("3")
  end




  ########## James Iteration 4 Team Tests ########

end
