class Player
  include Initializable
  include StatsRequest
  include StatsHash

  attr_accessor :first_name,
                :last_name,
                :only_current,
                :data

  def initialize(*args)
    super(*args)
    last_formatted = last_name.downcase.capitalize
    first_formatted = first_name.downcase.capitalize

    name = "#{last_formatted}, #{first_formatted}"
    list = PlayerList.new.info

    list['rowSet'].each do |player|
      @data = player if player[1] == name
    end
  end

  def id
    @data[0]
  end

  def player_code
    @data[5]
  end

  def rostered?
    @data[2].zero?
  end

  def team_id
    @data[6]
  end

  def team_name
    @data[7] + ' ' + @data[8]
  end

  def team_abbreviation
    @data[9]
  end

  def team_code
    @data[10]
  end
end

class PlayerList
  include Initializable
  include StatsRequest
  include StatsHash

  attr_accessor :league_id,
                :season,
                :only_current,
                :data

  def initialize(*args)
    super(*args)

    @league_id ||= League.NBA
    @season ||= NbaRb::CURRENT_SEASON
    @only_current ||= 1

    res = stats_request('commonallplayers', 'LeagueID' => league_id,
                                            'Season' => season,
                                            'IsOnlyCurrentSeason' => only_current)

    @data = res['resultSets']
  end

  def info
    @data[0]
  end
end

class PlayerSummary
  include Initializable
  include StatsRequest
  include StatsHash

  attr_accessor :player_id,
                :data

  def initialize(*args)
    super(*args)
    @player_id ||= player_id

    res = stats_request('commonplayerinfo', 'PlayerID' => player_id)

    @data = res['resultSets']
  end

  def info
    create_stats_hash(@data[0])
  end

  def headline_stats
    create_stats_hash(@data[1])
  end
end

class PlayerDashboard
  include Initializable
  include StatsRequest
  include StatsHash

  class << self
    attr_reader :endpoint
  end

  def endpoint
    self.class.endpoint
  end

  attr_accessor :player_id,
                :team_id,
                :measure_type,
                :per_mode,
                :plus_minus,
                :pace_adjust,
                :rank,
                :league_id,
                :season,
                :season_type,
                :po_round,
                :outcome,
                :location,
                :month,
                :season_segment,
                :date_from,
                :date_to,
                :opponent_team_id,
                :vs_conference,
                :vs_division,
                :game_segment,
                :period,
                :shot_clock_range,
                :last_n_games,
                :data

  @endpoint = ''

  def initialize(*args)
    super(*args)

    @team_id ||= 0
    @measure_type ||= MeasureType.default
    @per_mode ||= PerMode.default
    @plus_minus ||= PlusMinus.default
    @pace_adjust ||= PaceAdjust.default
    @rank ||= PaceAdjust.default
    @league_id ||= League.default
    @season ||= NbaRb::CURRENT_SEASON
    @season_type ||= SeasonType.default
    @po_round ||= PlayoffRound.default
    @outcome ||= Outcome.default
    @location ||= Location.default
    @month ||= Month.default
    @season_segment ||= SeasonSegment.default
    @date_from ||= DateFrom.default
    @date_to ||= DateTo.default
    @opponent_team_id ||= OpponentTeamID.default
    @vs_conference ||= VsConference.default
    @vs_division ||= VsDivision.default
    @game_segment ||= GameSegment.default
    @period ||= Period.default
    @shot_clock_range ||= ShotClockRange.default
    @last_n_games ||= LastNGames.default

    res = stats_request(endpoint, 'PlayerID' => player_id,
                                  'TeamID' => team_id,
                                  'MeasureType' => measure_type,
                                  'PerMode' => per_mode,
                                  'PlusMinus' => plus_minus,
                                  'PaceAdjust' => pace_adjust,
                                  'Rank' => rank,
                                  'LeagueID' => league_id,
                                  'Season' => season,
                                  'SeasonType' => season_type,
                                  'PORound' => po_round,
                                  'Outcome' => outcome,
                                  'Location' => location,
                                  'Month' => month,
                                  'SeasonSegment' => season_segment,
                                  'DateFrom' => date_from,
                                  'DateTo' => date_to,
                                  'OpponentTeamID' => opponent_team_id,
                                  'VsConference' => vs_conference,
                                  'VsDivision' => vs_division,
                                  'GameSegment' => game_segment,
                                  'Period' => period,
                                  'ShotClockRange' => shot_clock_range,
                                  'LastNGames' => last_n_games)

    @data = res['resultSets']
  end

  def overall
    create_stats_hash(@data[0])
  end
end

class PlayerGeneralSplits < PlayerDashboard
  @endpoint = 'playerdashboardbygeneralsplits'

  def location
    create_stats_hash(@data[1])
  end

  def home
    location[0]
  end

  def away
    location[1]
  end

  def win_losses
    create_stats_hash(@data[2])
  end

  def in_wins
    win_losses[0]
  end

  def in_losses
    win_losses[1]
  end

  def by_month
    create_stats_hash(@data[3])
  end

  def in_october
    by_month[0]
  end

  def in_november
    by_month[1]
  end

  def in_december
    by_month[2]
  end

  def in_january
    by_month[3]
  end

  def in_february
    by_month[4]
  end

  def in_march
    by_month[5]
  end

  def in_april
    by_month[6]
  end

  def in_may
    by_month[7]
  end

  def in_june
    by_month[8]
  end

  def pre_post_all_star
    create_stats_hash(@data[4])
  end

  def pre_all_star
    pre_post_all_star[0]
  end

  def post_all_star
    pre_post_all_star[1]
  end

  def starting_position
    create_stats_hash(@data[5])
  end

  def as_starter
    starting_position[0]
  end

  def as_bench
    starting_position[1]
  end

  def days_rest
    create_stats_hash(@data[6])
  end

  def zero_rest_days
    days_rest[0]
  end

  def one_rest_day
    days_rest[1]
  end

  def two_rest_days
    days_rest[2]
  end

  def three_rest_days
    days_rest[3]
  end

  def four_rest_days
    days_rest[4]
  end

  def six_plus_rest_days
    days_rest[5]
  end
end

class PlayerOpponentSplits < PlayerDashboard
  @endpoint = 'playerdashboardbyopponent'

  def by_conference
    create_stats_hash(@data[1])
  end

  def vs_east
    by_conference[0]
  end

  def vs_west
    by_conference[1]
  end

  def by_division
    create_stats_hash(@data[2])
  end

  def vs_division(division)
    by_division.each do |hash|
      return hash if hash['GROUP_VALUE'].downcase.include? division.downcase
    end
  end

  def by_opponent
    create_stats_hash(@data[3])
  end

  def vs_team(team)
    by_opponent.each do |hash|
      return hash if hash['GROUP_VALUE'].downcase.include? team.downcase
    end
  end
end

class PlayerLastNGamesSplits < PlayerDashboard
  @endpoint = 'playerdashboardbylastngames'

  def last5
    create_stats_hash(@data[1])
  end

  def last10
    create_stats_hash(@data[2])
  end

  def last15
    create_stats_hash(@data[3])
  end

  def last20
    create_stats_hash(@data[4])
  end

  def gamenumber
    create_stats_hash(@data[5])
  end
end

class PlayerInGameSplits < PlayerDashboard
  @endpoint = 'playerdashboardbygamesplits'

  def by_half
    create_stats_hash(@data[1])
  end

  def first_half
    by_half[0]
  end

  def second_half
    by_half[1]
  end

  def by_period
    create_stats_hash(@data[2])
  end

  def first_quarter
    by_period[0]
  end

  def second_quarter
    by_period[1]
  end

  def third_quarter
    by_period[2]
  end

  def fourth_quarter
    by_period[3]
  end

  def by_score_margin
    create_stats_hash(@data[3])
  end

  def tied_games
    by_score_margin[0]
  end

  def close_games
    by_score_margin[1]
  end

  def by_actual_margin
    create_stats_hash(@data[4])
  end
end

class PlayerClutchSplits < PlayerDashboard
  @endpoint = 'playerdashboardbyclutch'

  def last5min_deficit_5point
    ''"
    Results in last 5 minutes <= 5 points
    "''
    create_stats_hash(@data[1])
  end

  def last3min_deficit_5point
    ''"
    Results in last 5 minutes <= 5 points
    "''
    create_stats_hash(@data[2])
  end

  def last1min_deficit_5point
    ''"
    Results in last 5 minutes <= 5 points
    "''
    create_stats_hash(@data[3])
  end

  def last30sec_deficit_3point
    ''"
    Results in last 5 minutes <= 5 points
    "''
    create_stats_hash(@data[4])
  end

  def last10sec_deficit_3point
    ''"
    Results in last 5 minutes <= 5 points
    "''
    create_stats_hash(@data[5])
  end

  def last5min_plusminus_5point
    ''"
    Last 5 minutes +/= 5 points
    "''
    create_stats_hash(@data[6])
  end

  def last3min_plusminus_5point
    ''"
    Last 3 minutes +/= 5 points
    "''
    create_stats_hash(@data[7])
  end

  def last1min_plusminus_5point
    ''"
    Last 1 minutes +/= 5 points
    "''
    create_stats_hash(@data[8])
  end

  def last30sec_plusminus_5point
    ''"
    Last 30 seconds +/= 3 points
    "''
    create_stats_hash(@data[9])
  end
end

class PlayerShootingSplits < PlayerDashboard
  @endpoint = 'playerdashboardbyshootingsplits'

  def shot_5ft
    create_stats_hash(@data[1])
  end

  def shot_8ft
    create_stats_hash(@data[2])
  end

  def shot_areas
    create_stats_hash(@data[3])
  end

  def assisted_shots
    create_stats_hash(@data[4])
  end

  def shot_types_summary
    create_stats_hash(@data[5])
  end

  def shot_types_detail
    create_stats_hash(@data[6])
  end

  def assissted_by
    create_stats_hash(@data[7])
  end
end

class PlayerPerformanceSplits < PlayerDashboard
  @endpoint = 'playerdashboardbyteamperformance'

  def score_differential
    create_stats_hash(@data[1])
  end

  def points_scored
    create_stats_hash(@data[2])
  end

  def points_against
    create_stats_hash(@data[3])
  end
end

class PlayerYearOverYearSplits < PlayerDashboard
  @endpoint = 'playerdashboardbyyearoveryear'

  def splits_by_year
    create_stats_hash(@data[1])
  end

  def by_year(year)
    splits_by_year.each do |hash|
      return hash if hash['GROUP_VALUE'].include? year
    end
  end
end

class PlayerCareer
  include Initializable
  include StatsRequest
  include StatsHash

  class << self
    attr_reader :endpoint
  end

  def endpoint
    self.class.endpoint
  end

  attr_accessor :player_id,
                :league_id,
                :per_mode,
                :data

  def initialize(*args)
    super(*args)

    @per_mode ||= PerMode.per_game
    @league_id ||= League.NBA

    res = stats_request('playercareerstats', 'PlayerID' => player_id,
                                             'LeagueID' => league_id,
                                             'PerMode' => per_mode)

    @data = res['resultSets']
  end

  def regular_season_totals
    create_stats_hash(@data[0])
  end

  def season_totals_by_year(year)
    regular_season_totals.each do |hash|
      return hash if hash['SEASON_ID'].include? year
    end
  end

  def regular_season_career_totals
    create_stats_hash(@data[1])
  end

  def post_season_totals
    create_stats_hash(@data[2])
  end

  def post_season_totals_by_year(year)
    post_season_totals.each do |hash|
      return hash if hash['SEASON_ID'].include? year
    end
  end

  def post_season_career_totals
    create_stats_hash(@data[3])
  end

  def all_star_season_totals
    create_stats_hash(@data[4])
  end

  def all_star_season_totals_by_year(year)
    all_star_season_totals.each do |hash|
      return hash if hash['SEASON_ID'].include? year
    end
  end

  def career_all_star_season_totals
    create_stats_hash(@data[5])
  end

  def college_season_totals
    create_stats_hash(@data[6])
  end

  def college_season_totals_by_year(year)
    college_season_totals.each do |hash|
      return hash if hash['SEASON_ID'].include? year
    end
  end

  def career_college_season_totals
    create_stats_hash(@data[7])
  end

  def regular_season_rankings
    create_stats_hash(@data[8])
  end

  def regular_season_rankings_by_year(year)
    regular_season_rankings.each do |hash|
      return hash if hash['SEASON_ID'].include? year
    end
  end

  def post_season_rankings
    create_stats_hash(@data[9])
  end

  def post_season_rankings_by_year(year)
    post_season_rankings.each do |hash|
      return hash if hash['SEASON_ID'].include? year
    end
  end
end

class PlayerProfile < PlayerCareer
  @endpoint = 'playerprofilev2'

  def season_highs
    create_stats_hash(@data[10])
  end

  def career_highs
    create_stats_hash(@data[11])
  end

  def next_game
    create_stats_hash(@data[12])
  end
end

class PlayerGameLogs
  include Initializable
  include StatsRequest
  include StatsHash

  attr_accessor :player_id,
                :league_id,
                :season,
                :season_type,
                :data

  def initialize(*args)
    super(*args)

    @league_id ||= League.NBA
    @season ||= NbaRb::CURRENT_SEASON
    @season_type ||= SeasonType.regular

    res = stats_request('playergamelog', 'PlayerID' => player_id,
                                         'LeagueID' => league_id,
                                         'Season' => season,
                                         'SeasonType' => season_type)

    @data = res['resultSets']
  end

  def info
    create_stats_hash(@data[0])
  end
end

class PlayerShotTracking < PlayerDashboard
  @endpoint = 'playerdashptshots'

  def general_shooting
    create_stats_hash(@data[1])
  end

  def shot_clock_shooting
    create_stats_hash(@data[2])
  end

  def dribble_shooting
    create_stats_hash(@data[3])
  end

  def closest_defender_shooting
    create_stats_hash(@data[4])
  end

  def closest_defender_shooting_long
    create_stats_hash(@data[5])
  end

  def touch_time_shooting
    create_stats_hash(@data[6])
  end
end

class PlayerReboundTracking < PlayerDashboard
  @endpoint = 'playerdashptreb'

  def shot_type_rebounding
    create_stats_hash(@data[1])
  end

  def num_contested_rebounding
    create_stats_hash(@data[2])
  end

  def shot_distance_rebounding
    create_stats_hash(@data[3])
  end

  def rebound_distance_rebounding
    create_stats_hash(@data[4])
  end
end

class PlayerPassTracking < PlayerDashboard
  @endpoint = 'playerdashptpass'

  def passes_made
    create_stats_hash(@data[0])
  end

  def passes_recieved
    create_stats_hash(@data[1])
  end
end

class PlayerDefenseTracking < PlayerDashboard
  @endpoint = 'playerdashptshotdefend'
end

class PlayerShotLogTracking < PlayerDashboard
  @endpoint = 'playerdashptshotlog'
end

class PlayerReboundLogTracking < PlayerDashboard
  @endpoint = 'playerdashptreboundlogs'
end

class PlayerVsPlayer
  include Initializable
  include StatsRequest
  include StatsHash

  attr_accessor :player_id,
                :vs_player_id,
                :team_id,
                :measure_type,
                :per_mode,
                :plus_minus,
                :pace_adjust,
                :rank,
                :league_id,
                :season,
                :season_type,
                :po_round,
                :outcome,
                :location,
                :month,
                :season_segment,
                :date_from,
                :date_to,
                :opponent_team_id,
                :vs_conference,
                :vs_division,
                :game_segment,
                :period,
                :shot_clock_range,
                :last_n_games,
                :data

  def initialize(*args)
    super(*args)

    @team_id ||= 0
    @measure_type ||= MeasureType.default
    @per_mode ||= PerMode.default
    @plus_minus ||= PlusMinus.default
    @pace_adjust ||= PaceAdjust.default
    @rank ||= PaceAdjust.default
    @league_id ||= League.default
    @season ||= NbaRb::CURRENT_SEASON
    @season_type ||= SeasonType.default
    @po_round ||= PlayoffRound.default
    @outcome ||= Outcome.default
    @location ||= Location.default
    @month ||= Month.default
    @season_segment ||= SeasonSegment.default
    @date_from ||= DateFrom.default
    @date_to ||= DateTo.default
    @opponent_team_id ||= OpponentTeamID.default
    @vs_conference ||= VsConference.default
    @vs_division ||= VsDivision.default
    @game_segment ||= GameSegment.default
    @period ||= Period.default
    @shot_clock_range ||= ShotClockRange.default
    @last_n_games ||= LastNGames.default

    res = stats_request('playervsplayer', 'PlayerID' => player_id,
                                          'VsPlayerID' => vs_player_id,
                                          'TeamID' => team_id,
                                          'MeasureType' => measure_type,
                                          'PerMode' => per_mode,
                                          'PlusMinus' => plus_minus,
                                          'PaceAdjust' => pace_adjust,
                                          'Rank' => rank,
                                          'LeagueID' => league_id,
                                          'Season' => season,
                                          'SeasonType' => season_type,
                                          'PORound' => po_round,
                                          'Outcome' => outcome,
                                          'Location' => location,
                                          'Month' => month,
                                          'SeasonSegment' => season_segment,
                                          'DateFrom' => date_from,
                                          'DateTo' => date_to,
                                          'OpponentTeamID' => opponent_team_id,
                                          'VsConference' => vs_conference,
                                          'VsDivision' => vs_division,
                                          'GameSegment' => game_segment,
                                          'Period' => period,
                                          'ShotClockRange' => shot_clock_range,
                                          'LastNGames' => last_n_games)

    @data = res['resultSets']
  end

  def overall
    create_stats_hash(@data[0])
  end

  def on_off_court
    create_stats_hash(@data[1])
  end

  def shot_distance_overall
    create_stats_hash(@data[2])
  end

  def shot_distance_on_court
    create_stats_hash(@data[3])
  end

  def shot_distance_off_court
    create_stats_hash(@data[4])
  end

  def shot_area_overall
    create_stats_hash(@data[5])
  end

  def shot_area_on_court
    create_stats_hash(@data[6])
  end

  def shot_area_off_court
    create_stats_hash(@data[7])
  end

  def player_info
    create_stats_hash(@data[8])
  end

  def vs_player_info
    create_stats_hash(@data[9])
  end
end
