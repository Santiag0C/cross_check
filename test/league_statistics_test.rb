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

  def test_group_by_teams
    assert_equal 7, @stat_tracker.group_by_teams.length
  end

  def test_return_team_name
    assert_equal "Devils", @stat_tracker.return_team_name('1')
  end

  def test_gg_method
    expected = {"6"=>3.5,
                 "3"=>2.5,
                 "5"=>2.2,
                 "16"=>2.0,
                 "4"=>3.0,
                 "26"=>3.0,
                 "10"=>2.75,
                 "52"=>3.0,
                 "25"=>1.5,
                 "29"=>2.0,
                 "15"=>4.0,
                 "21"=>3.6666666666666665,
                 "30"=>3.5,
                 "1"=>0.5,
                 "8"=>1.0,
                 "28"=>1.0,
                 "9"=>3.0,
                 "12"=>2.75,
                 "24"=>2.0,
                 "23"=>3.0,
                 "53"=>4.0,
                 "13"=>1.0,
                 "22"=>2.0,
                 "2"=>5.0,
                 "17"=>3.0,
                 "14"=>5.0 }

    espected_f = {"3"=>1.6666666666666667,
                  "6"=>3.6666666666666665,
                  "5"=>2.25,
                  "17"=>2.0,
                  "16"=>4.5,
                  "15"=>4.5,
                  "4"=>2.0,
                  "9"=>2.5,
                  "28"=>2.0,
                  "26"=>3.3333333333333335,
                  "8"=>3.0,
                  "10"=>4.0,
                  "52"=>2.0,
                  "25"=>0.0,
                  "22"=>4.666666666666667,
                  "7"=>3.0,
                  "1"=>3.0,
                  "21"=>3.3333333333333335,
                  "30"=>4.0,
                  "14"=>2.0,
                  "53"=>3.0,
                  "19"=>3.3333333333333335,
                  "23"=>2.0,
                  "13"=>1.0 }
    assert_equal expected, @stat_tracker.gg(true)
    assert_equal espected_f, @stat_tracker.gg(false)

  end

  def test_highest_scoring_visitor
    assert_equal "Oilers", @stat_tracker.highest_scoring_visitor
  end

  def test_highest_scoring_home_team
    assert_equal "Lightning", @stat_tracker.highest_scoring_home_team
  end

  def test_lowest_scoring_visitor
    assert_equal "Stars", @stat_tracker.lowest_scoring_visitor
  end

  def test_lowest_scoring_home_team
    assert_equal "Devils", @stat_tracker.lowest_scoring_home_team
  end
end
