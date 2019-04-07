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
    # For each season that the team has played, a hash that has two keys (:regular_season and :postseason), that each point to a hash with the following keys:
    # :win_percentage,
    # :total_goals_scored,
    # :total_goals_against,
    # :average_goals_scored,
    # :average_goals_against.	Hash


    # Create array of years
    # create array of season type (reg vs post)

    #year_arr.each do
    # => create hash with year as key

    #   => season_type_arr.each do
    #     => create hash with season_type as key
    #     => Same hash will have hashes as values
    #         => those hashes will have stat names as keys, stats as values.

    year_hash = {}
    season_type_hash = {}
    stats_hash = {}

    years = @games.map { |game| game.season}.uniq
    season_type = @games.map { |game| game.type}.uniq

    years.each do |year|
      year_hash[year] = season_type_hash

      season_type.each do |type|
        season_type_hash[type] = stats_hash

              subject_games = @games.find_all do |game|
                team_in_game = team_id == game.home_team_id || team_id == game.away_team_id
                game_in_season_type = type == game.type
                game_in_season = year == game.season

                team_in_game && game_in_season_type && game_in_season
              end

              # win_percentage = 0 ----------- (done)
              # total_goals_scored = 0
              # total_goals_against = 0
              # average_goals_scored = 0
              # average_goals_against = 0

              stats_hash[:win_percentage] = subject_games.count do |subject_game|
                if subject_game.home_team_id == team_id
                  subject_game.home_goals > subject_game.away_goals
                else
                  subject_game.away_goals > subject_game.home_goals
                end
              end / subject_games.length.to_f


              # total_goals_scored = subject_games.sum


                # :total_goals_against,
                # :average_goals_scored,
                # :average_goals_against.

                binding.pry
      end
    end


  end



    ########### James Iteration 4 Team Statistics #################

end
