require './lib/helpers/initialize'

class Player
  include Initializable
  attr_accessor :first_name,
                :last_name,
                :only_current,
                :data

  def initialize(*args)
    super(*args)
    only_current ||= 1
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
    !@data[2].zero?
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
  attr_accessor :league_id,
                :season,
                :only_current,
                :data

  def initialize(*args)
    super(*args)
    league_id ||= League.NBA
    season ||= NbaRb::CURRENT_SEASON
    only_current ||= 1

    @league_id = league_id
    @season = season
    @only_current = only_current

    uri = URI.parse(NbaRb::BASE_URL + 'commonallplayers')
    response = Net::HTTP.post_form(uri, 'LeagueID': league_id,
                                        'Season': season,
                                        'IsOnlyCurrentSeason': only_current)
    parsed_response = JSON.parse(response.body)
    @data = parsed_response['resultSets']
  end

  def info
    @data[0]
  end
end

class PlayerSummary
  include Initializable
  attr_accessor :player_id,
                :data

  def initialize(*args)
    super(*args)
    @player_id ||= player_id

    uri = URI.parse(NbaRb::BASE_URL + 'commonplayerinfo')
    response = Net::HTTP.post_form(uri, 'PlayerID': player_id)
    parsed_response = JSON.parse(response.body)
    @data = parsed_response['resultSets']
  end

  def info
    @data[0]
  end

  def headline_stats
    @data[1]
  end
end

class PlayerDashboard
  include Initializable

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

    team_id ||= 0
    measure_type ||= MeasureType.default
    per_mode ||= PerMode.default
    plus_minus ||= PlusMinus.default
    pace_adjust ||= PaceAdjust.default
    rank ||= PaceAdjust.default
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
    response = Net::HTTP.post_form(uri, 'PlayerID': player_id,
                                        'TeamID': team_id,
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

class PlayerGeneralSplits < PlayerDashboard
  @endpoint = 'playerdashboardbygeneralsplits'

  def location
    @data[1]
  end

  def win_losses
    @data[2]
  end

  def pre_post_all_star
    @data[3]
  end

  def starting_position
    @data[4]
  end

  def days_rest
    @data[5]
  end
end

class PlayerOpponentSplits < PlayerDashboard
  @endpoint = 'playerdashboardbyopponent'

  def by_conference
    @data[1]
  end

  def by_division
    @data[2]
  end

  def by_opponent
    @data[3]
  end
end

class PlayerLastNGamesSplits < PlayerDashboard
  @endpoint = 'playerdashboardbylastngames'

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

class PlayerInGameSplits < PlayerDashboard
  @endpoint = 'playerdashboardbygamesplits'

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

class PlayerClutchSplits < PlayerDashboard
  @endpoint = 'playerdashboardbyclutch'

  def last5min_deficit_5point
    ''"
    Results in last 5 minutes <= 5 points
    "''
    @data[1]
  end

  def last3min_deficit_5point
    ''"
    Results in last 5 minutes <= 5 points
    "''
    @data[2]
  end

  def last1min_deficit_5point
    ''"
    Results in last 5 minutes <= 5 points
    "''
    @data[3]
  end

  def last30sec_deficit_3point
    ''"
    Results in last 5 minutes <= 5 points
    "''
    @data[4]
  end

  def last10sec_deficit_3point
    ''"
    Results in last 5 minutes <= 5 points
    "''
    @data[5]
  end

  def last5min_plusminus_5point
    ''"
    Last 5 minutes +/= 5 points
    "''
    @data[6]
  end

  def last3min_plusminus_5point
    ''"
    Last 3 minutes +/= 5 points
    "''
    @data[7]
  end

  def last1min_plusminus_5point
    ''"
    Last 1 minutes +/= 5 points
    "''
    @data[8]
  end

  def last30sec_plusminus_5point
    ''"
    Last 30 seconds +/= 3 points
    "''
    @data[9]
  end
end

class PlayerShootingSplits < PlayerDashboard
  @endpoint = 'playerdashboardbyshootingsplits'

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

  def shot_types_summary
    @data[5]
  end

  def shot_types_detail
    @data[6]
  end

  def assissted_by
    @data[7]
  end
end

class PlayerPerformanceSplits < PlayerDashboard
  @endpoint = 'playerdashboardbyteamperformance'

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

class PlayerYearOverYearSplits < PlayerDashboard
  @endpoint = 'playerdashboardbyyearoveryear'

  def by_year
    @data[1]
  end
end

class PlayerCareer
  include Initializable
  class << self
    attr_reader :endpoint
  end

  def endpoint
    self.class.endpoint
  end

  def initialize(*args)
    super(*args)

    per_mode ||= PerMode.per_game
    league_id ||= League.NBA

    uri = URI.parse(NbaRb::BASE_URL + 'playercareerstats')
    response = Net::HTTP.post_form(uri, 'PlayerID': player_id,
                                        'LeagueID': league_id,
                                        'PerMode': per_mode)

    parsed_response = JSON.parse(response.body)
    @data = parsed_response['resultSets']
  end

  def regular_season_totals
    @data[0]
  end

  def regular_season_career_totals
    @data[1]
  end

  def post_season_totals
    @data[2]
  end

  def post_season_career_totals
    @data[3]
  end

  def all_star_season_totals
    @data[4]
  end

  def career_all_star_season_totals
    @data[5]
  end

  def college_season_totals
    @data[6]
  end

  def career_college_season_totals
    @data[7]
  end

  def regular_season_rankings
    @data[8]
  end

  def post_season_rankings
    @data[9]
  end
end

class PlayerProfile < PlayerCareer
  @endpoint = 'playerprofilev2'

  def season_highs
    @data[10]
  end

  def career_highs
    @data[11]
  end

  def next_game
    @data[12]
  end
end

class PlayerGameLogs
  include Initializable
  attr_accessor :player_id,
                :league_id,
                :season,
                :season_type,
                :data

  def initialize(*args)
    super(*args)

    league_id ||= League.NBA
    season ||= NbaRb::CURRENT_SEASON
    season_type ||= SeasonType.regular

    uri = URI.parse(NbaRb::BASE_URL + 'playergamelog')
    response = Net::HTTP.post_form(uri, 'PlayerID': player_id,
                                        'LeagueID': league_id,
                                        'Season': season,
                                        'SeasonType': season_type)

    parsed_response = JSON.parse(response.body)
    @data = parsed_response['resultSets']
  end

  def info
    @data[0]
  end
end

class PlayerShotTracking < PlayerDashboard
  @endpoint = 'playerdashptshots'

  def general_shooting
    @data[1]
  end

  def shot_clock_shooting
    @data[2]
  end

  def dribble_shooting
    @data[3]
  end

  def closest_defender_shooting
    @data[4]
  end

  def closest_defender_shooting_long
    @data[5]
  end

  def touch_time_shooting
    @data[6]
  end
end

class PlayerReboundTracking < PlayerDashboard
  @endpoint = 'playerdashptreb'

  def shot_type_rebounding
    @data[1]
  end

  def num_contested_rebounding
    @data[2]
  end

  def shot_distance_rebounding
    @data[3]
  end

  def rebound_distance_rebounding
    @data[4]
  end
end

class PlayerPassTracking < PlayerDashboard
  @endpoint = 'playerdashptpass'

  def passes_made
    @data[0]
  end

  def passes_recieved
    @data[1]
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

    team_id ||= 0
    measure_type ||= MeasureType.default
    per_mode ||= PerMode.default
    plus_minus ||= PlusMinus.default
    pace_adjust ||= PaceAdjust.default
    rank ||= PaceAdjust.default
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

    uri = URI.parse(NbaRb::BASE_URL + 'playervsplayer')
    response = Net::HTTP.post_form(uri, 'PlayerID': player_id,
                                        'VsPlayerID': vs_player_id,
                                        'TeamID': team_id,
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

  def on_off_court
    @data[1]
  end

  def shot_distance_overall
    @data[2]
  end

  def shot_distance_on_court
    @data[3]
  end

  def shot_distance_off_court
    @data[4]
  end

  def shot_area_overall
    @data[5]
  end

  def shot_area_on_court
    @data[6]
  end

  def shot_area_off_court
    @data[7]
  end

  def player_info
    @data[8]
  end

  def vs_player_info
    @data[9]
  end
end
