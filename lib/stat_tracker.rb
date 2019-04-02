require 'csv'
require './lib/game'
require './lib/team'

class StatTracker
  attr_reader :games,
              :teams,
              :game_teams

  def initialize(data)
    @games = data[:games].map {|game| Game.new(game.to_hash)}
    @teams = data[:teams].map {|team| Team.new(team.to_hash)}
  end

  def self.from_csv(files)
    StatTracker.new({
            games: CSV.open(files[:games], headers: true),
            teams: CSV.open(files[:teams], headers: true)
            })
  end
end
