module NbaRb
  module Team
    class CommonRoster < BaseClass
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
  end
end
