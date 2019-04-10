require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/team'
require 'mocha/minitest'

class TeamTest < Minitest::Test
  def test_team_class_exist
    team_data = {
                "team_id" => "1",
                "franchiseId" => "23",
                "shortName" => "New Jersey",
                "teamName" => "Devils",
                "abbreviation" => "NJD",
                "link" => "/api/v1/teams/1"}

    team = Team.new(team_data)

    assert_instance_of Team, team
  end

  def test_team_class_has_attributes_mocks_stubs
    team = mock
    team.stubs("team_id").returns("1")
    team.stubs("franchiseId").returns("23")
    team.stubs("shortName").returns("New Jersey")
    team.stubs("teamName").returns("Devils")
    team.stubs("abbreviation").returns("NJD")
    team.stubs("link").returns("/api/v1/teams/1")

    assert_equal "1", team.team_id
    assert_equal "23", team.franchiseId
    assert_equal "New Jersey", team.shortName
    assert_equal "Devils", team.teamName
    assert_equal "NJD", team.abbreviation
    assert_equal "/api/v1/teams/1", team.link
  end

  def test_team_class_has_attributes_no_mocks_stubs
    team_data = {
                "team_id" => "1",
                "franchiseId" => "23",
                "shortName" => "New Jersey",
                "teamName" => "Devils",
                "abbreviation" => "NJD",
                "link" => "/api/v1/teams/1"}

    team = Team.new(team_data)

    assert_equal "1", team.team_id
    assert_equal "23", team.franchise_id
    assert_equal "New Jersey", team.short_name
    assert_equal "Devils", team.team_name
    assert_equal "NJD", team.abbreviation
    assert_equal "/api/v1/teams/1", team.link
  end

end
