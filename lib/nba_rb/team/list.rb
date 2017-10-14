module NbaRb
  module Team
    class List < NbaRb::Team::BaseClass
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
  end
end
