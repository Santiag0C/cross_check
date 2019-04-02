require 'pry'
class Game
  attr_reader :name
  
  def initialize(games)
    @name = games[:game_id]
    @season = games[:season]
    @type = games[:type]
    @date_time = games[:date_time]
    @away_team_id = games[:away_team_id]
    @home_team_id = games[:home_team_id]
    @away_goals = games[:away_goals]
    @home_goals = games[:home_goals]
    @home_rink_side_start = games[:home_rink_side_start]
    @venue = games[:venue]
    @venue_link = games[:venue_link]
    @venue_time_zone_id = games[:venue_time_zone_id]
    @venue_time_zone_offset = games[:venue_time_zone_offset]
    @venue_time_zone_tz = games[:venue_time_zone_tz]


    # binding.pry
  end
end
