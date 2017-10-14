module NbaRb
  module Player
    class GameLogs
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

        @league_id ||= NbaRb::League.NBA
        @season ||= NbaRb::CURRENT_SEASON
        @season_type ||= NbaRb::SeasonType.regular

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
  end
end
