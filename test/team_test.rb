require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/team'

class TeamTest < Minitest::Test
  def setup
    @team_data = {
                "team_id" => "1",
                "franchiseId" => "23",
                "shortName" => "New Jersey",
                "teamName" => "Devils",
                "abbreviation" => "NJD",
                "link" => "/api/v1/teams/1"}

    @team = Team.new(@team_data)
  end

  def test_team_class_exist
    assert_instance_of Team, @team
  end

  def test_team_class_has_attributes
    assert_equal "1", @team.team_id
    assert_equal "23", @team.franchise_id
    assert_equal "New Jersey", @team.short_name
    assert_equal "Devils", @team.team_name
    assert_equal "NJD", @team.abbreviation
    assert_equal "/api/v1/teams/1", @team.link
  end

end
