require 'pry'
module SeasonStatistics

  def biggest_bust

  end

  def biggest_surprise(season)

  end

  def hit_helper(season)
    hash = Hash.new{|h,k| h[k] = [] }
     count_of_games_by_season.keys.each do |season|
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
