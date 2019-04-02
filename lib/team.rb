class Team
  attr_reader :team_id,
              :franchiseId,
              :shortName,
              :teamName,
              :abbreviation,
              :link

  def initialize(file)
    @team_id = file["team_id"]
    @franchiseId = file["franchiseId"]
    @shortName = file["shortName"]
    @teamName = file["teamName"]
    @abbreviation = file["abbreviation"]
    @link = file["link"]
  end
end
