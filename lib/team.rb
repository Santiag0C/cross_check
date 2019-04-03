class Team
  attr_reader :team_id,
              :franchise_id,
              :short_name,
              :team_name,
              :abbreviation,
              :link

  def initialize(file)
    @team_id = file["team_id"]
    @franchise_id = file["franchiseId"]
    @short_name = file["shortName"]
    @team_name = file["teamName"]
    @abbreviation = file["abbreviation"]
    @link = file["link"]
  end
end
