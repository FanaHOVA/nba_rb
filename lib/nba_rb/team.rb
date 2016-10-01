class TeamList
  include StatsHash
  include Initializable
  include StatsRequest

  attr_accessor :league_id,
                :data

  def initialize(*args)
    super(*args)

    @league_id ||= NbaRb::League.NBA

    res = stats_request('commonteamyears', 'LeagueID' => league_id)

    @data = res['resultSets']
  end

  def info
    create_stats_hash(@data[0])
  end
end

class TeamSummary
  include Initializable
  include StatsRequest
  include StatsHash

  attr_accessor :team_id,
                :season,
                :league_id,
                :season_type,
                :data

  def initialize(*args)
    super(*args)

    @season ||= NbaRb::CURRENT_SEASON
    @league_id ||= NbaRb::League.NBA
    @season_type ||= NbaRb::SeasonType.default

    res = stats_request('teaminfocommon', 'TeamID' => team_id,
                                          'Season' => season,
                                          'LeagueID' => league_id,
                                          'SeasonType' => season_type)

    @data = res['resultSets']
  end

  def info
    create_stats_hash(@data[0])
  end

  def season_ranks
    create_stats_hash(@data[1])
  end
end

class TeamCommonRoster
  include Initializable
  include StatsRequest
  include StatsHash

  attr_accessor :team_id,
                :season,
                :data

  def initialize(*args)
    super(*args)

    @season ||= NbaRb::CURRENT_SEASON

    res = stats_request('commonteamroster', 'TeamID' => team_id,
                                            'Season' => season)

    @data = res['resultSets']
  end

  def roster
    create_stats_hash(@data[0])
  end

  def coaches
    create_stats_hash(@data[1])
  end
end

class TeamDashboard
  include Initializable
  include StatsRequest
  include StatsHash

  @endpoint = ''

  class << self
    attr_reader :endpoint
  end

  def endpoint
    self.class.endpoint
  end

  attr_accessor :team_id,
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

    @measure_type ||= NbaRb::MeasureType.default
    @per_mode ||= NbaRb::PerMode.default
    @plus_minus ||= NbaRb::PlusMinus.default
    @pace_adjust ||= NbaRb::PaceAdjust.default
    @rank ||= NbaRb::Rank.default
    @league_id ||= NbaRb::League.default
    @season ||= NbaRb::CURRENT_SEASON
    @season_type ||= NbaRb::SeasonType.default
    @po_round ||= NbaRb::PlayoffRound.default
    @outcome ||= NbaRb::Outcome.default
    @location ||= NbaRb::Location.default
    @month ||= NbaRb::Month.default
    @season_segment ||= NbaRb::SeasonSegment.default
    @date_from ||= NbaRb::DateFrom.default
    @date_to ||= NbaRb::DateTo.default
    @opponent_team_id ||= NbaRb::OpponentTeamID.default
    @vs_conference ||= NbaRb::VsConference.default
    @vs_division ||= NbaRb::VsDivision.default
    @game_segment ||= NbaRb::GameSegment.default
    @period ||= NbaRb::Period.default
    @shot_clock_range ||= NbaRb::ShotClockRange.default
    @last_n_games ||= NbaRb::LastNGames.default

    res = stats_request(endpoint, 'TeamID' => team_id,
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

class TeamGeneralSplits < TeamDashboard
  @endpoint = 'teamdashboardbygeneralsplits'

  def by_location
    create_stats_hash(@data[1])
  end

  def wins_losses
    create_stats_hash(@data[2])
  end

  def monthly
    create_stats_hash(@data[3])
  end

  def pre_post_all_star
    create_stats_hash(@data[4])
  end

  def days_rest
    create_stats_hash(@data[5])
  end
end

class TeamOpponentSplits < TeamDashboard
  @endpoint = 'teamdashboardbyopponent'

  def by_conference
    create_stats_hash(@data[1])
  end

  def by_division
    create_stats_hash(@data[2])
  end

  def by_opponent
    create_stats_hash(@data[3])
  end
end

class TeamLastNGamesSplits < TeamDashboard
  @endpoint = 'teamdashboardbylastngames'

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

class TeamInGameSplits < TeamDashboard
  @endpoint = 'teamdashboardbygamesplits'

  def by_half
    create_stats_hash(@data[1])
  end

  def by_period
    create_stats_hash(@data[2])
  end

  def by_score_margin
    create_stats_hash(@data[3])
  end

  def by_actual_margin
    create_stats_hash(@data[4])
  end
end

class TeamClutchSplits < TeamDashboard
  @endpoint = 'teamdashboardbyclutch'

  def last5min_deficit_5point
    # Results in last 5 minutes <= 5 points
    create_stats_hash(@data[1])
  end

  def last3min_deficit_5point
    # Results in last 5 minutes <= 5 points
    create_stats_hash(@data[2])
  end

  def last1min_deficit_5point
    # Results in last 5 minutes <= 5 points
    create_stats_hash(@data[3])
  end

  def last30sec_deficit_3point
    # Results in last 5 minutes <= 5 points
    create_stats_hash(@data[4])
  end

  def last10sec_deficit_3point
    # Results in last 5 minutes <= 5 points
    create_stats_hash(@data[5])
  end

  def last5min_plusminus_5point
    # Last 5 minutes +/= 5 points
    create_stats_hash(@data[6])
  end

  def last3min_plusminus_5point
    # Last 3 minutes +/= 5 points
    create_stats_hash(@data[7])
  end

  def last1min_plusminus_5point
    # Last 1 minutes +/= 5 points
    create_stats_hash(@data[8])
  end

  def last30sec_plusminus_5point
    # Last 30 seconds +/= 3 points
    create_stats_hash(@data[9])
  end
end

class TeamShootingSplits < TeamDashboard
  @endpoint = 'teamdashboardbyshootingsplits'

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

  def shot_type_summary
    create_stats_hash(@data[5])
  end

  def shot_type_detail
    create_stats_hash(@data[6])
  end

  def assissted_by
    create_stats_hash(@data[7])
  end
end

class TeamPerformanceSplits < TeamDashboard
  @endpoint = 'teamdashboardbyteamperformance'

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

class TeamYearOverYearSplits < TeamDashboard
  @endpoint = 'teamdashboardbyyearoveryear'

  def by_year
    create_stats_hash(@data[1])
  end
end

class TeamLineups
  include Initializable
  include StatsRequest
  include StatsHash

  attr_accessor :team_id,
                :game_id,
                :group_quantity,
                :season,
                :season_type,
                :measure_type,
                :per_mode,
                :plus_minus,
                :pace_adjust,
                :rank,
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
                :last_n_games,
                :data

  def initialize(*args)
    super(*args)

    @game_id ||= ''
    @group_quantity ||= NbaRb::GroupQuantity.default
    @season ||= NbaRb::CURRENT_SEASON
    @season_type ||= NbaRb::SeasonType.default
    @measure_type ||= NbaRb::MeasureType.default
    @per_mode ||= NbaRb::PerMode.default
    @plus_minus ||= NbaRb::PlusMinus.default
    @pace_adjust ||= NbaRb::PaceAdjust.default
    @rank ||= NbaRb::Rank.default
    @outcome ||= NbaRb::Outcome.default
    @location ||= NbaRb::Location.default
    @month ||= NbaRb::Month.default
    @season_segment ||= NbaRb::SeasonSegment.default
    @date_from ||= NbaRb::DateFrom.default
    @date_to ||= NbaRb::DateTo.default
    @opponent_team_id ||= NbaRb::OpponentTeamID.default
    @vs_conference ||= NbaRb::VsConference.default
    @vs_division ||= NbaRb::VsDivision.default
    @game_segment ||= NbaRb::GameSegment.default
    @period ||= NbaRb::Period.default
    @last_n_games ||= NbaRb::LastNGames.default

    res = stats_request('teamdashlineups', 'GroupQuantity' => group_quantity,
                                           'GameID' => game_id,
                                           'TeamID' => team_id,
                                           'Season' => season,
                                           'SeasonType' => season_type,
                                           'MeasureType' => measure_type,
                                           'PerMode' => per_mode,
                                           'PlusMinus' => plus_minus,
                                           'PaceAdjust' => pace_adjust,
                                           'Rank' => rank,
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
                                           'LastNGames' => last_n_games)

    @data = res['resultSets']
  end

  def overall
    create_stats_hash(@data[0])
  end

  def lineups
    create_stats_hash(@data[1])
  end
end

class TeamPlayers < TeamDashboard
  @endpoint = 'teamplayerdashboard'

  def season_totals
    create_stats_hash(@data[1])
  end
end

class TeamPlayerOnOffDetail < TeamDashboard
  @endpoint = 'teamplayeronoffdetails'

  def on_court
    create_stats_hash(@data[1])
  end

  def off_court
    create_stats_hash(@data[2])
  end
end

class TeamPlayerOnOffSummary < TeamDashboard
  @endpoint = 'teamplayeronoffsummary'

  def on_court
    create_stats_hash(@data[1])
  end

  def off_court
    create_stats_hash(@data[2])
  end
end

class TeamGameLogs
  include Initializable
  include StatsRequest
  include StatsHash

  attr_accessor :team_id,
                :season,
                :season_type,
                :data

  def initialize(*args)
    super(*args)

    @season ||= NbaRb::CURRENT_SEASON
    @season_type ||= NbaRb::SeasonType.default

    res = stats_request('teamgamelog', 'TeamID' => team_id,
                                       'Season' => season,
                                       'SeasonType' => season_type)

    @data = res['resultSets']
  end

  def info
    create_stats_hash(@data[1])
  end
end

class TeamSeasons
  include Initializable
  include StatsRequest
  include StatsHash

  attr_accessor :team_id,
                :season_type,
                :per_mode

  def initialize(*args)
    super(*args)

    @season_type ||= NbaRb::SeasonType.Default
    @per_mode ||= NbaRb::PerMode.Default

    res = stats_request('teamyearbyyearstats', 'TeamID' => team_id,
                                               'SeasonType' => season_type,
                                               'PerMode' => per_mode)

    @data = res['resultSets']
  end

  def info
    create_stats_hash(@data[1])
  end
end

class TeamShotTracking < TeamDashboard
  @endpoint = 'teamdashptshots'

  def shot_clock_shooting
    create_stats_hash(@data[1])
  end

  def dribble_shooting
    create_stats_hash(@data[2])
  end

  def closest_defender_shooting
    create_stats_hash(@data[3])
  end

  def closest_defender_shooting_long
    create_stats_hash(@data[4])
  end

  def touch_time_shooting
    create_stats_hash(@data[5])
  end
end

class TeamReboundTracking < TeamDashboard
  @endpoint = 'teamdashptreb'

  def shot_type_rebounding
    create_stats_hash(@data[1])
  end

  def contested_rebounding
    create_stats_hash(@data[2])
  end

  def shot_distance_rebounding
    create_stats_hash(@data[3])
  end

  def rebound_distance_rebounding
    create_stats_hash(@data[4])
  end
end

class TeamPassTracking < TeamDashboard
  @endpoint = 'teamdashptpass'

  def passes_made
    create_stats_hash(@data[0])
  end

  def passes_recieved
    create_stats_hash(@data[1])
  end
end

class TeamVsPlayer
  include Initializable
  include StatsRequest
  include StatsHash

  attr_accessor :team_id,
                :vs_player_id,
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

    @measure_type ||= NbaRb::MeasureType.default
    @per_mode ||= NbaRb::PerMode.default
    @plus_minus ||= NbaRb::PlusMinus.default
    @pace_adjust ||= NbaRb::PaceAdjust.default
    @rank ||= NbaRb::Rank.default
    @league_id ||= NbaRb::League.default
    @season ||= NbaRb::CURRENT_SEASON
    @season_type ||= NbaRb::SeasonType.default
    @po_round ||= NbaRb::PlayoffRound.default
    @outcome ||= NbaRb::Outcome.default
    @location ||= NbaRb::Location.default
    @month ||= NbaRb::Month.default
    @season_segment ||= NbaRb::SeasonSegment.default
    @date_from ||= NbaRb::DateFrom.default
    @date_to ||= NbaRb::DateTo.default
    @opponent_team_id ||= NbaRb::OpponentTeamID.default
    @vs_conference ||= NbaRb::VsConference.default
    @vs_division ||= NbaRb::VsDivision.default
    @game_segment ||= NbaRb::GameSegment.default
    @period ||= NbaRb::Period.default
    @shot_clock_range ||= NbaRb::ShotClockRange.default
    @last_n_games ||= NbaRb::LastNGames.default

    res = stats_request('teamvsplayer', 'TeamID' => team_id,
                                        'VsPlayerID' => vs_player_id,
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

  def vs_player_overall
    create_stats_hash(@data[1])
  end

  def on_off_court
    create_stats_hash(@data[2])
  end

  def shot_distance_overall
    create_stats_hash(@data[3])
  end

  def shot_distance_on_court
    create_stats_hash(@data[4])
  end

  def shot_distance_off_court
    create_stats_hash(@data[5])
  end

  def shot_area_overall
    create_stats_hash(@data[6])
  end

  def shot_area_on_court
    create_stats_hash(@data[7])
  end

  def shot_area_off_court
    create_stats_hash(@data[8])
  end
end
