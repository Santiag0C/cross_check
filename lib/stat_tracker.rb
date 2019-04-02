require 'pry'
require 'csv'
require './lib/game'
class StatTracker
  attr_reader :games

  def initialize

  end
  def self.from_csv(locations)
    games = CSV.foreach(locations[:games], headers: true, header_converters: :symbol)
    games.map do |game|
      gameh = game.to_h
      Game.new(gameh)
      #binding.pry
    end
    # teams = CSV.foreach(locations[:teams], headers: true, header_converters: :symbol)
    # teams.each do |team|
    #   Teams.new(team)
    # end
    # game_teams = CSV.foreach(locations[:game_teams], headers: true, header_converters: :symbol)
    # game_teams.each do |game_team|
    #   GameTeams.new(game_team)
    # end
  end
end
