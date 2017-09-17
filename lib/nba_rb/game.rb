class Boxscore
  include Initializable
  include StatsRequest
  include StatsHash

  @endpoint = 'boxscoretraditionalv2'

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

    @range_type ||= NbaRb::RangeType.default
    @start_period ||= NbaRb::Period.default
    @end_period ||= NbaRb::Period.default
    @start_range ||= NbaRb::StartRange.default
    @end_range ||= NbaRb::EndRange.default

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
  @endpoint = 'boxscorescoringv2'

  def endpoint
    self.class.endpoint
  end

  def matchup
    scores = players_scoring
    home_team = scores[0]['TEAM_ABBREVIATION']
    away_team = scores.last['TEAM_ABBREVIATION']
  end

  def players_scoring
    create_stats_hash(@data[13])
  end

  def team_scoring
    create_stats_hash(@data[14])
  end
end

class BoxscoreUsage < Boxscore
  @endpoint = 'boxscoreusagev2'

  def endpoint
    self.class.endpoint
  end

  def players_usage
    create_stats_hash(@data[13])
  end

  def team_usage
    create_stats_hash(@data[14])
  end
end

class BoxscoreMisc < Boxscore
  @endpoint = 'boxscoremiscv2'

  def endpoint
    self.class.endpoint
  end

  def players_misc
    create_stats_hash(@data[13])
  end

  def team_misc
    create_stats_hash(@data[14])
  end
end

class BoxscoreAdvanced < Boxscore
  @endpoint = 'boxscoreadvancedv2'

  def players_advanced
    create_stats_hash(@data[13])
  end

  def team_advanced
    create_stats_hash(@data[14])
  end
end

class BoxscoreFourFactors < Boxscore
  @endpoint = 'boxscorefourfactorsv2'

  def endpoint
    self.class.endpoint
  end

  def players_four_factors
    create_stats_hash(@data[13])
  end

  def team_four_factors
    create_stats_hash(@data[14])
  end
end

class PlayByPlay
  include Initializable
  include StatsRequest
  include StatsHash

  def initialize(*args)
    super(*args)

    @start_period ||= NbaRb::Period.default
    @end_period ||= NbaRb::Period.default

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
