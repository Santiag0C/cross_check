module SeasonStatistics


  def season_gather #helper
    seasons =[]
      @games.each do |game|
        seasons << game.season
      end
    seasons.uniq
  end

  def hit_helper(season)
    hash = Hash.new{|h,k| h[k] = [] }
     season_gather.each do |season|
      @games.each do |game|
        if game.season == season
          hash[season].push(game.game_id)
        end
      end
    end
    team_hits = Hash.new(0)
      hash[season].each do |game_i|
        @game_teams.each do |game|
        if game_i == game.game_id
          team_hits[game.team_id] += game.hits
        end
      end
    end
  team_hits
  end

  def most_hits(season)
    @teams.each do |team|
      highest = hit_helper(season).invert.max
      if team.team_id == highest[1]
        return team.team_name
      end
    end
  end

  def fewest_hits(season)
    @teams.each do |team|
      highest = hit_helper(season).invert.min
      if team.team_id == highest[1]
        return team.team_name
      end
    end
  end
end
