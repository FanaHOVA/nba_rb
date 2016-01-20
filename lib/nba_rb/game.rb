require 'initialize'

class Boxscore
  @endpoint = 'boxscore'

  class << self
    attr_reader :endpoint
  end

  def endpoint
    self.class.endpoint
  end

  attr_accessor :game_id,
                :range_type,
                :start_period,
                :end_period,
                :start_range,
                :end_range,
                :data

  def initialize(game_id,
                 range_type = RangeType.default,
                 start_period = Period.default,
                 end_period = Period.default,
                 start_range = StartRange.default,
                 end_range = EndRange.default
                )

    @game_id = game_id
    @range_type = range_type
    @start_period = start_period
    @end_period = end_period
    @start_range = start_range
    @end_range = end_range

    uri = URI.parse(NbaRb::BASE_URL + endpoint)
    response = Net::HTTP.post_form(uri, 'GameID' => @game_id,
                                        'RangeType' => range_type,
                                        'StartPeriod' => start_period,
                                        'EndPeriod' => end_period,
                                        'StartRange' => start_range,
                                        'EndRange' => end_range)

    parsed_response = JSON.parse(response.body)
    @data = parsed_response['resultSets']
  end

  def game_summary
    @data[0]
  end

  def line_score
    @data[1]
  end

  def season_series
    @data[2]
  end

  def last_meeting
    @data[3]
  end

  def player_stats
    @data[4]
  end

  def team_stats
    @data[5]
  end

  def other_stats
    @data[6]
  end

  def officials
    @data[7]
  end

  def game_info
    @data[8]
  end

  def inactive_players
    @data[9]
  end

  def available_video
    @data[10]
  end

  def player_track
    @data[11]
  end

  def player_track_team
    @data[12]
  end
end

class BoxscoreScoring < Boxscore
  @endpoint = 'boxscorescoring'

  def endpoint
    self.class.endpoint
  end

  def sql_players_scoring
    @data[13]
  end

  def sql_team_scoring
    @data[14]
  end
end

class BoxscoreUsage < Boxscore
  @endpoint = 'boxscoreusage'

  def endpoint
    self.class.endpoint
  end

  def sql_players_usage
    @data[13]
  end

  def sql_team_usage
    @data[14]
  end
end

class BoxscoreMisc < Boxscore
  @endpoint = 'boxscoremisc'

  def endpoint
    self.class.endpoint
  end

  def sql_players_misc
    @data[13]
  end

  def sql_team_misc
    @data[14]
  end
end

class BoxscoreAdvanced < Boxscore
  @endpoint = 'boxscoreadvanced'

  def sql_players_advanced
    @data[13]
  end

  def sql_team_advanced
    @data[14]
  end
end

class BoxscoreFourFactors < Boxscore
  @endpoint = 'boxscorefourfactors'

  def endpoint
    self.class.endpoint
  end

  def sql_players_four_factors
    @data[13]
  end

  def sql_team_four_factors
    @data[14]
  end
end

class PlayByPlay
  def initialize(game_id,
                 start_period = Period.default,
                 end_period = Period.default)

    @game_id = game_id
    @start_period = start_period
    @end_period = end_period

    uri = URI.parse(NbaRb::BASE_URL + 'playbyplay')
    response = Net::HTTP.post_form(uri, 'GameID' => @game_id,
                                        'StartPeriod' => start_period,
                                        'EndPeriod' => end_period)

    parsed_response = JSON.parse(response.body)
    @data = parsed_response['resultSets']
  end

  def info
    @data[0]
  end

  def available_video
    @data[1]
  end
end
