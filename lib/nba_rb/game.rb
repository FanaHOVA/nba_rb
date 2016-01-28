class Boxscore
  include Initializable
  include StatsRequest
  include StatsHash

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

  def initialize(*args)
    super(*args)

    @range_type ||= RangeType.default
    @start_period ||= Period.default
    @end_period ||= Period.default
    @start_range ||= StartRange.default
    @end_range ||= EndRange.default

    res = stats_request(endpoint, 'GameID' => game_id,
                                  'RangeType' => range_type,
                                  'StartPeriod' => start_period,
                                  'EndPeriod' => end_period,
                                  'StartRange' => start_range,
                                  'EndRange' => end_range)

    @data = res['resultSets']
  end

  def game_summary
    create_stats_hash(@data[0])
  end

  def line_score
    create_stats_hash(@data[1])
  end

  def season_series
    create_stats_hash(@data[2])
  end

  def last_meeting
    create_stats_hash(@data[3])
  end

  def player_stats
    create_stats_hash(@data[4])
  end

  def team_stats
    create_stats_hash(@data[5])
  end

  def other_stats
    create_stats_hash(@data[6])
  end

  def officials
    create_stats_hash(@data[7])
  end

  def game_info
    create_stats_hash(@data[8])
  end

  def inactive_players
    create_stats_hash(@data[9])
  end

  def available_video
    create_stats_hash(@data[10])
  end

  def player_track
    create_stats_hash(@data[11])
  end

  def player_track_team
    create_stats_hash(@data[12])
  end
end

class BoxscoreScoring < Boxscore
  @endpoint = 'boxscorescoring'

  def endpoint
    self.class.endpoint
  end

  def sql_players_scoring
    create_stats_hash(@data[13])
  end

  def sql_team_scoring
    create_stats_hash(@data[14])
  end
end

class BoxscoreUsage < Boxscore
  @endpoint = 'boxscoreusage'

  def endpoint
    self.class.endpoint
  end

  def sql_players_usage
    create_stats_hash(@data[13])
  end

  def sql_team_usage
    create_stats_hash(@data[14])
  end
end

class BoxscoreMisc < Boxscore
  @endpoint = 'boxscoremisc'

  def endpoint
    self.class.endpoint
  end

  def sql_players_misc
    create_stats_hash(@data[13])
  end

  def sql_team_misc
    create_stats_hash(@data[14])
  end
end

class BoxscoreAdvanced < Boxscore
  @endpoint = 'boxscoreadvanced'

  def sql_players_advanced
    create_stats_hash(@data[13])
  end

  def sql_team_advanced
    create_stats_hash(@data[14])
  end
end

class BoxscoreFourFactors < Boxscore
  @endpoint = 'boxscorefourfactors'

  def endpoint
    self.class.endpoint
  end

  def sql_players_four_factors
    create_stats_hash(@data[13])
  end

  def sql_team_four_factors
    create_stats_hash(@data[14])
  end
end

class PlayByPlay
  include Initializable
  include StatsRequest
  include StatsHash

  def initialize(*args)
    super(*args)

    @start_period ||= Period.default
    @end_period ||= Period.default

    res = stats_request('playbyplay', 'GameID' => @game_id,
                                      'StartPeriod' => start_period,
                                      'EndPeriod' => end_period)

    @data = res['resultSets']
  end

  def info
    create_stats_hash(@data[0])
  end

  def available_video
    create_stats_hash(@data[1])
  end
end
