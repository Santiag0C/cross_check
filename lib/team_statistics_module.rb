module TeamStatistics
  def team_info(team_id)
    team = teams.find{|team| team.team_id == team_id}
    keys = team.instance_variables.map {|key| key.to_s.delete("@")}
    team_info = Hash[keys.map {|x| [x]}]; i = 0
    team.instance_variables.each do |value|
      team_info[keys[i]] = team.instance_variable_get(value); i += 1
    end
    team_info
  end

  def best_season(team_id)
    team_winning_percentage_all_seasons(team_id).max_by{|k,v| v}[0]
  end

  def worst_season(team_id)
    team_winning_percentage_all_seasons(team_id).min_by{|k,v| v}[0]
  end

  def average_win_percentage(team_id)
    (team_wins[team_id].to_f / games_per_team[team_id]).round(2)
  end

  def most_goals_scored(team_id)
    team_game = goals_by_team(team_id).max_by do |game|
      game.home_team_id == team_id ? game.home_goals : game.away_goals
    end
    team_game.home_team_id == team_id ? team_game.home_goals : team_game.away_goals
  end

  def fewest_goals_scored(team_id)
    team_game = goals_by_team(team_id).min_by do |game|
      game.home_team_id == team_id ? game.home_goals : game.away_goals
    end
    team_game.home_team_id == team_id ? team_game.home_goals : team_game.away_goals
  end

  def favorite_opponent(team_id)
    head_to_head(team_id).max_by{|k,v| v}[0]
  end

  def rival(team_id)
    head_to_head(team_id).min_by{|k,v| v}[0]
  end

  def biggest_team_blowout(team_id)
    games.map do |game|
      game.away_goals - game.home_goals if game.away_team_id == team_id
      game.home_goals - game.away_goals if game.home_team_id == team_id
    end.compact.max
  end

  def worst_loss(team_id)
    games.map do |game|
      (game.away_goals - game.home_goals if game.away_team_id == team_id) ||
      (game.home_goals - game.away_goals if game.home_team_id == team_id)
    end.compact.min.abs
  end

  def head_to_head(team_id)
    subject_team_games = @games.group_by do |game|
      game.home_team_id == team_id || game.away_team_id == team_id
    end[true]

    subject_team_opponent_array = subject_team_games.map do |game|
      if team_id == game.home_team_id
        game.away_team_id
      else
        game.home_team_id
      end
    end

    teams_and_record = {}
    subject_team_opponent_array.uniq.each do |opponent|
      wins = 0
      losses = 0
      subject_team_games.each do |game|
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





  def seasonal_summary(team_id)
    year_hash = {}

    years = @games.map { |game| game.season}.uniq

    years.each do |year|

      regular_season_games = @games.find_all do |game|
        team_in_game = team_id == game.home_team_id || team_id == game.away_team_id
        game_in_season = year == game.season
        regular_season = game.type == "R"

        team_in_game && game_in_season && regular_season
      end

      postseason_games = @games.find_all do |game|
        team_in_game = team_id == game.home_team_id || team_id == game.away_team_id
        game_in_season = year == game.season
        postseason = game.type == "P"

        team_in_game && game_in_season && postseason
      end

      ######### WIN_PERCENTAGE START #################
      if postseason_games.length == 0
        postseason_win_percentage = 0
      else
        postseason_win_percentage = postseason_games.count do |subject_game|
          if subject_game.home_team_id == team_id
            subject_game.home_goals > subject_game.away_goals
          else
            subject_game.away_goals > subject_game.home_goals
          end
        end / postseason_games.length.to_f
      end

      if regular_season_games.length == 0
        regular_season_win_percentage = 0
      else
        regular_season_win_percentage = regular_season_games.count do |subject_game|
          if subject_game.home_team_id == team_id
            subject_game.home_goals > subject_game.away_goals
          else
            subject_game.away_goals > subject_game.home_goals
          end
        end / regular_season_games.length.to_f
      end

      ######### TOTAL_GOALS_SCORED START #################
      postseason_total_goals_scored = postseason_games.sum do |game|
        if game.home_team_id == team_id
          game.home_goals
        else
          game.away_goals
        end
      end

      regular_season_total_goals_scored = regular_season_games.sum do |game|
        if game.home_team_id == team_id
          game.home_goals
        else
          game.away_goals
        end
      end

      ######### TOTAL_GOALS_AGAINST START #################
      postseason_total_goals_against = postseason_games.sum do |game|
        if game.home_team_id == team_id
          game.away_goals
        else
          game.home_goals
        end
      end

      regular_season_total_goals_against = regular_season_games.sum do |game|
        if game.home_team_id == team_id
          game.away_goals
        else
          game.home_goals
        end
      end

      ######### AVERAGE_GOALS_SCORED and _AGAINST START #################
      if postseason_games.length == 0
        postseason_average_goals_scored = 0.0
        postseason_average_goals_against = 0.0
      else
        postseason_average_goals_scored = (postseason_total_goals_scored.to_f / postseason_games.length).round(2)
        postseason_average_goals_against = (postseason_total_goals_against.to_f / postseason_games.length).round(2)
      end

      if regular_season_games.length == 0
        regular_season_average_goals_scored = 0.0
        regular_season_average_goals_against = 0.0
      else
        regular_season_average_goals_scored = (regular_season_total_goals_scored.to_f / regular_season_games.length).round(2)
        regular_season_average_goals_against = (regular_season_total_goals_against.to_f / regular_season_games.length).round(2)
      end
      ######### AVERAGE_GOALS_SCORED and _AGAINST END #################

      postseason_stats_hash = {}
      regular_season_stats_hash = {}
      all_season_stats_hash = {}

      postseason_stats_hash[:win_percentage] = postseason_win_percentage.round(2)
      postseason_stats_hash[:total_goals_scored] = postseason_total_goals_scored
      postseason_stats_hash[:total_goals_against] = postseason_total_goals_against
      postseason_stats_hash[:average_goals_scored] = postseason_average_goals_scored
      postseason_stats_hash[:average_goals_against] = postseason_average_goals_against
      regular_season_stats_hash[:win_percentage] = regular_season_win_percentage.round(2)
      regular_season_stats_hash[:total_goals_scored] = regular_season_total_goals_scored
      regular_season_stats_hash[:total_goals_against] = regular_season_total_goals_against
      regular_season_stats_hash[:average_goals_scored] = regular_season_average_goals_scored
      regular_season_stats_hash[:average_goals_against] = regular_season_average_goals_against

      all_season_stats_hash[:postseason] = postseason_stats_hash
      all_season_stats_hash[:regular_season] = regular_season_stats_hash

      year_hash[year] = all_season_stats_hash
    end
    year_hash
  end

  #helper
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

  def goals_by_team(team_id)
    @games.group_by do |game|
      game.home_team_id == team_id || game.away_team_id == team_id
    end[true]
  end
end
