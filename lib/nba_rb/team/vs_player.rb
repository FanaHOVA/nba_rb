module NbaRb
  module Team
    class VsPlayer
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
  end
end
