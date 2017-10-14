module NbaRb
  module Player
    class List
      include Initializable
      include StatsRequest
      include StatsHash

      attr_accessor :league_id,
                    :season,
                    :only_current,
                    :data

      def initialize(*args)
        super(*args)

        @league_id ||= NbaRb::League.NBA
        @season ||= NbaRb::CURRENT_SEASON
        @only_current ||= 1

        res = stats_request('commonallplayers', 'LeagueID' => league_id,
                                                'Season' => season,
                                                'IsOnlyCurrentSeason' => only_current)

        @data = res['resultSets']
      end

      def info
        @data[0]
      end
    end
  end
end
