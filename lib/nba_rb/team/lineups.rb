module NbaRb
  module Team
    class Lineups
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
  end
end
