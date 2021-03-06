class GameTeams
  attr_reader :game_id,
              :team_id,
              :hoa,
              :won,
              :settled_in,
              :head_coach,
              :goals,
              :shots,
              :hits,
              :pim,
              :power_play_opportunities,
              :power_play_goals,
              :face_off_win_percentage,
              :giveaways,
              :takeaways

  def initialize(file)
    @game_id = file["game_id"]
    @team_id = file["team_id"]
    @hoa = file["HoA"]
    @won = file["won"].downcase
    @settled_in = file["settled_in"]
    @head_coach = file["head_coach"]
    @goals = file["goals"].to_i
    @shots = file["shots"].to_i
    @hits = file["hits"].to_i
    @pim = file["pim"].to_i
    @power_play_opportunities = file["powerPlayOpportunities"].to_i
    @power_play_goals = file["powerPlayGoals"].to_i
    @face_off_win_percentage = file["faceOffWinPercentage"].to_f
    @giveaways = file["giveaways"].to_i
    @takeaways = file["takeaways"].to_i
  end
end
