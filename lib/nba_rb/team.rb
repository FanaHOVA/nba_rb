require './lib/helpers/initialize'

class TeamList
  include Initializable
  attr_accessor :league_id,
                :data

  def initialize(*args)
    super(*args)

    league_id ||= League.NBA

    uri = URI.parse(NbaRb::BASE_URL + 'commonteamyears')
    response = Net::HTTP.post_form(uri, 'LeagueID': league_id)

    parsed_response = JSON.parse(response.body)
    @data = parsed_response['resultSets']
  end

  def info
    @data[0]
  end
end

class TeamSummary
  attr_accessor :team_id,
                :season,
                :league_id,
                :season_type,
                :data

  def initialize(*args)
    super(*args)

    season ||= NbaRb::NbaRb::CURRENT_SEASON
    league_id ||= League.NBA
    season_type ||= SeasonType.default

    uri = URI.parse(NbaRb::BASE_URL + 'teaminfocommon')
    response = Net::HTTP.post_form(uri, 'TeamID': team_id,
                                        'Season': season,
                                        'LeagueID': league_id,
                                        'SeasonType': season_type)
    parsed_response = JSON.parse(response.body)
    @data = parsed_response['resultSets']
  end

  def info
    @data[0]
  end

  def season_ranks
    @data[1]
  end
end

class TeamCommonRoster
  include Initializable

  attr_accessor :team_id,
                :season,
                :data

  def initialize(*args)
    super(*args)

    season ||= NbaRb::CURRENT_SEASON

    uri = URI.parse(NbaRb::BASE_URL + 'commonteamroster')
    response = Net::HTTP.post_form(uri, 'TeamID': team_id,
                                        'Season': season)

    parsed_response = JSON.parse(response.body)
    @data = parsed_response['resultSets']
  end

  def roster
    @data[0]
  end

  def coaches
    @data[1]
  end
end

class TeamDashboard
  include Initializable
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

    measure_type ||= MeasureType.default
    per_mode ||= PerMode.default
    plus_minus ||= PlusMinus.default
    pace_adjust ||= PaceAdjust.default
    rank ||= Rank.default
    league_id ||= League.default
    season ||= NbaRb::CURRENT_SEASON
    season_type ||= SeasonType.default
    po_round ||= PlayoffRound.default
    outcome ||= Outcome.default
    location ||= Location.default
    month ||= Month.default
    season_segment ||= SeasonSegment.default
    date_from ||= DateFrom.default
    date_to ||= DateTo.default
    opponent_team_id ||= OpponentTeamID.default
    vs_conference ||= VsConference.default
    vs_division ||= VsDivision.default
    game_segment ||= GameSegment.default
    period ||= Period.default
    shot_clock_range ||= ShotClockRange.default
    last_n_games ||= LastNGames.default

    uri = URI.parse(NbaRb::BASE_URL + @endpoint)
    response = Net::HTTP.post_form(uri, 'TeamID': team_id,
                                        'MeasureType': measure_type,
                                        'PerMode': per_mode,
                                        'PlusMinus': plus_minus,
                                        'PaceAdjust': pace_adjust,
                                        'Rank': rank,
                                        'LeagueID': league_id,
                                        'Season': season,
                                        'SeasonType': season_type,
                                        'PORound': po_round,
                                        'Outcome': outcome,
                                        'Location': location,
                                        'Month': month,
                                        'SeasonSegment': season_segment,
                                        'DateFrom': date_from,
                                        'DateTo': date_to,
                                        'OpponentTeamID': opponent_team_id,
                                        'VsConference': vs_conference,
                                        'VsDivision': vs_division,
                                        'GameSegment': game_segment,
                                        'Period': period,
                                        'ShotClockRange': shot_clock_range,
                                        'LastNGames': last_n_games)

    parsed_response = JSON.parse(response.body)
    @data = parsed_response['resultSets']
  end

  def overall
    @data[0]
  end
end

class TeamGeneralSplits < TeamDashboard
  @endpoint = 'teamdashboardbygeneralsplits'

  def location
    @data[1]
  end

  def wins_losses
    @data[2]
  end

  def monthly
    @data[3]
  end

  def pre_post_all_star
    @data[4]
  end

  def days_rest
    @data[5]
  end
end

class TeamOpponentSplits < TeamDashboard
  @endpoint = 'teamdashboardbyopponent'

  def by_conference
    @data[1]
  end

  def by_division
    @data[2]
  end

  def by_opponent
    @data[2]
  end
end

class TeamLastNGamesSplits < TeamDashboard
  @endpoint = 'teamdashboardbylastngames'

  def last5
    @data[1]
  end

  def last10
    @data[2]
  end

  def last15
    @data[3]
  end

  def last20
    @data[4]
  end

  def gamenumber
    @data[5]
  end
end

class TeamInGameSplits < TeamDashboard
  @endpoint = 'teamdashboardbygamesplits'

  def by_half
    @data[1]
  end

  def by_period
    @data[2]
  end

  def by_score_margin
    @data[3]
  end

  def by_actual_margin
    @data[4]
  end
end

class TeamClutchSplits < TeamDashboard
  @endpoint = 'teamdashboardbyclutch'

  def last5min_deficit_5point
    # Results in last 5 minutes <= 5 points
    @data[1]
  end

  def last3min_deficit_5point
    # Results in last 5 minutes <= 5 points
    @data[2]
  end

  def last1min_deficit_5point
    # Results in last 5 minutes <= 5 points
    @data[3]
  end

  def last30sec_deficit_3point
    # Results in last 5 minutes <= 5 points
    @data[4]
  end

  def last10sec_deficit_3point
    # Results in last 5 minutes <= 5 points
    @data[5]
  end

  def last5min_plusminus_5point
    # Last 5 minutes +/= 5 points
    @data[6]
  end

  def last3min_plusminus_5point
    # Last 3 minutes +/= 5 points
    @data[7]
  end

  def last1min_plusminus_5point
    # Last 1 minutes +/= 5 points
    @data[8]
  end

  def last30sec_plusminus_5point
    # Last 30 seconds +/= 3 points
    @data[9]
  end
end

class TeamShootingSplits < TeamDashboard
  @endpoint = 'teamdashboardbyshootingsplits'

  def shot_5ft
    @data[1]
  end

  def shot_8ft
    @data[2]
  end

  def shot_areas
    @data[3]
  end

  def assisted_shots
    @data[4]
  end

  def shot_type_summary
    @data[5]
  end

  def shot_type_detail
    @data[6]
  end

  def assissted_by
    @data[7]
  end
end

class TeamPerformanceSplits < TeamDashboard
  @endpoint = 'teamdashboardbyteamperformance'

  def score_differential
    @data[1]
  end

  def points_scored
    @data[2]
  end

  def points_against
    @data[3]
  end
end

class TeamYearOverYearSplits < TeamDashboard
  @endpoint = 'teamdashboardbyyearoveryear'

  def by_year
    @data[1]
  end
end

class TeamLineups
  include Initializable
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

    game_id ||= ''
    group_quantity ||= GroupQuantity.default
    season ||= NbaRb::CURRENT_SEASON
    season_type ||= SeasonType.default
    measure_type ||= MeasureType.default
    per_mode ||= PerMode.default
    plus_minus ||= PlusMinus.default
    pace_adjust ||= PaceAdjust.default
    rank ||= Rank.default
    outcome ||= Outcome.default
    location ||= Location.default
    month ||= Month.default
    season_segment ||= SeasonSegment.default
    date_from ||= DateFrom.default
    date_to ||= DateTo.default
    opponent_team_id ||= OpponentTeamID.default
    vs_conference ||= VsConference.default
    vs_division ||= VsDivision.default
    game_segment ||= GameSegment.default
    period ||= Period.default
    last_n_games ||= LastNGames.default

    uri = URI.parse(NbaRb::BASE_URL + 'teamdashlineups')
    response = Net::HTTP.post_form(uri, 'GroupQuantity': group_quantity,
                                        'GameID': game_id,
                                        'TeamID': team_id,
                                        'Season': season,
                                        'SeasonType': season_type,
                                        'MeasureType': measure_type,
                                        'PerMode': per_mode,
                                        'PlusMinus': plus_minus,
                                        'PaceAdjust': pace_adjust,
                                        'Rank': rank,
                                        'Outcome': outcome,
                                        'Location': location,
                                        'Month': month,
                                        'SeasonSegment': season_segment,
                                        'DateFrom': date_from,
                                        'DateTo': date_to,
                                        'OpponentTeamID': opponent_team_id,
                                        'VsConference': vs_conference,
                                        'VsDivision': vs_division,
                                        'GameSegment': game_segment,
                                        'Period': period,
                                        'LastNGames': last_n_games)

    parsed_response = JSON.parse(response.body)
    @data = parsed_response['resultSets']
  end

  def overall
  @data[0]
  end

  def lineups
  @data[1]
  end
end

class TeamPlayers < TeamDashboard
  @endpoint = 'teamplayerdashboard'

  def season_totals
    @data[1]
  end
end

class TeamPlayerOnOffDetail < TeamDashboard
  @endpoint = 'teamplayeronoffdetails'

  def on_court
    @data[1]
  end

  def off_court
    @data[2]
  end
end

class TeamPlayerOnOffSummary < TeamDashboard
  @endpoint = 'teamplayeronoffsummary'

  def on_court
    @data[1]
  end

  def off_court
    @data[2]
  end
end

class TeamGameLogs
  include Initializable
  attr_accessor :team_id,
                :season,
                :season_type,
                :data

  def initialize(*args)
    super(*args)

    season ||= NbaRb::CURRENT_SEASON
    season_type ||= SeasonType.default

    uri = URI.parse(NbaRb::BASE_URL + 'teamgamelog')
    response = Net::HTTP.post_form(uri, 'TeamID': team_id,
                                        'Season': season,
                                        'SeasonType': season_type)

    parsed_response = JSON.parse(response.body)
    @data = parsed_response['resultSets']
  end

  def info
    @data[1]
  end
end

class TeamSeasons
  include Initializable
  attr_accessor :team_id,
                :season_type,
                :per_mode

  def initialize(*args)
    super(*args)

    season_type ||= SeasonType.Default
    per_mode ||= PerMode.Default

    uri = URI.parse(NbaRb::BASE_URL + 'teamyearbyyearstats')
    response = Net::HTTP.post_form(uri, 'TeamID': team_id,
                                        'SeasonType': season_type,
                                        'PerMode': per_mode)

    parsed_response = JSON.parse(response.body)
    @data = parsed_response['resultSets']
  end

  def info
    @data[1]
  end
end

class TeamShotTracking < TeamDashboard
  @endpoint = 'teamdashptshots'

  def shot_clock_shooting
    @data[1]
  end

  def dribble_shooting
    @data[2]
  end

  def closest_defender_shooting
    @data[3]
  end

  def closest_defender_shooting_long
    @data[4]
  end

  def touch_time_shooting
    @data[5]
  end
end

class TeamReboundTracking < TeamDashboard
  @endpoint = 'teamdashptreb'

  def shot_type_rebounding
    @data[1]
  end

  def contested_rebounding
    @data[2]
  end

  def shot_distance_rebounding
    @data[3]
  end

  def rebound_distance_rebounding
    @data[4]
  end
end

class TeamPassTracking < TeamDashboard
  @endpoint = 'teamdashptpass'

  def passes_made
    @data[0]
  end

  def passes_recieved
    @data[1]
  end
end

class TeamVsPlayer
  include Initializable
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

    measure_type ||= MeasureType.default
    per_mode ||= PerMode.default
    plus_minus ||= PlusMinus.default
    pace_adjust ||= PaceAdjust.default
    rank ||= Rank.default
    league_id ||= League.default
    season ||= NbaRb::CURRENT_SEASON
    season_type ||= SeasonType.default
    po_round ||= PlayoffRound.default
    outcome ||= Outcome.default
    location ||= Location.default
    month ||= Month.default
    season_segment ||= SeasonSegment.default
    date_from ||= DateFrom.default
    date_to ||= DateTo.default
    opponent_team_id ||= OpponentTeamID.default
    vs_conference ||= VsConference.default
    vs_division ||= VsDivision.default
    game_segment ||= GameSegment.default
    period ||= Period.default
    shot_clock_range ||= ShotClockRange.default
    last_n_games ||= LastNGames.default

    uri = URI.parse(NbaRb::BASE_URL + 'teamvsplayer')
    response = Net::HTTP.post_form(uri, 'TeamID': team_id,
                                        'VsPlayerID': vs_player_id,
                                        'MeasureType': measure_type,
                                        'PerMode': per_mode,
                                        'PlusMinus': plus_minus,
                                        'PaceAdjust': pace_adjust,
                                        'Rank': rank,
                                        'LeagueID': league_id,
                                        'Season': season,
                                        'SeasonType': season_type,
                                        'PORound': po_round,
                                        'Outcome': outcome,
                                        'Location': location,
                                        'Month': month,
                                        'SeasonSegment': season_segment,
                                        'DateFrom': date_from,
                                        'DateTo': date_to,
                                        'OpponentTeamID': opponent_team_id,
                                        'VsConference': vs_conference,
                                        'VsDivision': vs_division,
                                        'GameSegment': game_segment,
                                        'Period': period,
                                        'ShotClockRange': shot_clock_range,
                                        'LastNGames': last_n_games)

    parsed_response = JSON.parse(response.body)
    @data = parsed_response['resultSets']
  end

  def overall
    @data[0]
  end

  def vs_player_overall
    @data[1]
  end

  def on_off_court
    @data[2]
  end

  def shot_distance_overall
    @data[3]
  end

  def shot_distance_on_court
    @data[4]
  end

  def shot_distance_off_court
    @data[5]
  end

  def shot_area_overall
    @data[6]
  end

  def shot_area_on_court
    @data[7]
  end

  def shot_area_off_court
    @data[8]
  end
end
