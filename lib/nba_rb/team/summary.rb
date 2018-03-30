module NbaRb
  module Team
    class Summary < BaseClass
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
  end
end
