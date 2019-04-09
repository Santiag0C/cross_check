module HelperTeamStatistics
  def team_winning_percentage_all_seasons(team_id)
    seasons = Hash.new{|h,k| h[k] = []}
    @games.each {|game| seasons[game.season] << game if (game.away_team_id == team_id || game.home_team_id == team_id)}
    team_wps = {}
    seasons.keys.each do |key|
      wins = []
      seasons[key].each{|game| wins << game if game.outcome.include?("home win") && game.home_team_id == team_id}
      seasons[key].each{|game| wins << game if game.outcome.include?("away win") && game.away_team_id == team_id}
      wins_percentage = wins.length.to_f / seasons[key].length
      team_wps[key] = wins_percentage
    end
    team_wps
  end

  def game_by_team(team_id)
    @games.group_by do |game|
      game.home_team_id == team_id || game.away_team_id == team_id
    end[true]
  end

  def teams_and_record(opponents, team_id)
    teams_and_record = {}
    opponents.uniq.each do |opponent|
      wins = 0
      losses = 0
      game_by_team(team_id).each do |game|
        if opponent == game.home_team_id
          if game.home_goals > game.away_goals
            losses += 1
          else
            wins += 1
          end
        elsif opponent == game.away_team_id
          if game.away_goals > game.home_goals
            losses += 1
          else
            wins += 1
          end
        end
      end
      record = (wins.to_f / (wins + losses)).round(2)
      teams_and_record[return_team_name(opponent)] = record
    end
    teams_and_record
  end
end
