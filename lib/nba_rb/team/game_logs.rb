module NbaRb
  module Team
    class GameLogs
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
  end
end
