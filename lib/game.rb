class Game
  attr_reader :game_id,
              :season,
              :type,
              :date_time,
              :away_team_id,
              :home_team_id,
              :away_goals,
              :home_goals,
              :outcome,
              :home_rink_side_start,
              :venue,
              :venue_link,
              :venue_time_zone_id,
              :venue_time_zone_offset,
              :venue_time_zone_tz

  def initialize(file)
    @game_id = file["game_id"]
    @season = file["season"]
    @type = file["type"]
    @date_time = file["date_time"]
    @away_team_id = file["away_team_id"]
    @home_team_id = file["home_team_id"]
    @away_goals = file["away_goals"].to_i
    @home_goals = file["home_goals"].to_i
    @outcome = file["outcome"]
    @home_rink_side_start = file["home_rink_side_start"]
    @venue = file["venue"]
    @venue_link = file["venue_link"]
    @venue_time_zone_id = file["venue_time_zone_id"]
    @venue_time_zone_offset = file["venue_time_zone_offset"].to_i
    @venue_time_zone_tz = file["venue_time_zone_tz"]
  end
end
