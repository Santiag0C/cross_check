require 'pry'
module TeamStatistics

  ########### James Iteration 4 Team Statistics #################
  def biggest_team_blowout(team_id)
    @games.map do |game|
      if game.away_team_id == team_id
        game.away_goals - game.home_goals
      elsif game.home_team_id == team_id
        game.home_goals - game.away_goals
      end
    end.compact.max
  end

  def worst_loss(team_id)
    @games.map do |game|
      if game.away_team_id == team_id
        game.away_goals - game.home_goals
      elsif game.home_team_id == team_id
        game.home_goals - game.away_goals
      end
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

  #favorite_opponent	Name of the opponent that has the lowest win percentage against the given team.	String
  def favorite_opponent(team_id)
    head_to_head(team_id).max_by{|k,v| v}[0]
  end

  #rival	Name of the opponent that has the highest win percentage against the given team.	String
  def rival(team_id)
    head_to_head(team_id).min_by{|k,v| v}[0]
  end


  #most_goals_scored	Highest number of goals a particular team has scored in a single game.	Integer
  def most_goals_scored(team_id)
    subject_team_games = @games.group_by do |game|
      game.home_team_id == team_id || game.away_team_id == team_id
    end[true]

    occurence_game = subject_team_games.max_by do |game|
      if game.home_team_id == team_id
        game.home_goals
      else
        game.away_goals
      end
    end

    if occurence_game.home_team_id == team_id
      occurence_game.home_goals
    else
      occurence_game.away_goals
    end
  end

  #fewest_goals_scored	Lowest numer of goals a particular team has scored in a single game.	Integer
  def fewest_goals_scored(team_id)
    subject_team_games = @games.group_by do |game|
      game.home_team_id == team_id || game.away_team_id == team_id
    end[true]

    occurence_game = subject_team_games.min_by do |game|
      if game.home_team_id == team_id
        game.home_goals
      else
        game.away_goals
      end
    end

    if occurence_game.home_team_id == team_id
      occurence_game.home_goals
    else
      occurence_game.away_goals
    end
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
    ########### James Iteration 4 Team Statistics #################

end
