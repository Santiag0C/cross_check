require 'csv'
require_relative 'game'
require_relative 'team'
require_relative 'game_teams'

class StatTracker
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
