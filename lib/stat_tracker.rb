require 'csv'
require './lib/game'

class StatTracker
  attr_reader :games,
              :teams,
              :game_teams

  def initialize(data)
    @games = data[:games].map {|game| Game.new(game.to_hash)}
  end

  def self.from_csv(files)
    StatTracker.new({
            games: CSV.open(files[:games], headers: true)
            })
  end
end
