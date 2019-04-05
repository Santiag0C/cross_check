require 'csv'
require_relative 'game'
require_relative 'team'
require_relative 'game_teams'
require_relative 'game_statistics_module'
require_relative 'league_statistics_module'
require_relative 'team_statistics_module'
require 'pry'

class StatTracker
  include GameStatistics
  include LeagueStatistics
  include TeamStatistics

  attr_reader :games,
              :teams,
              :game_teams

  def initialize(data)
         @games = data[:games].map {|game| Game.new(game.to_hash)}
         @teams = data[:teams].map {|team| Team.new(team.to_hash)}
         @game_teams = data[:game_teams].map {|game_team| GameTeams.new(game_team.to_hash)}
  end

  def self.from_csv(files)
    StatTracker.new({
            games: CSV.open(files[:games], headers: true),
            teams: CSV.open(files[:teams], headers: true),
            game_teams: CSV.open(files[:game_teams], headers: true)
            })
  end
end
