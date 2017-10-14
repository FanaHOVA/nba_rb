module NbaRb
  module Player
    class Summary
      include Initializable
      include StatsRequest
      include StatsHash

      attr_accessor :player_id,
                    :data

      def initialize(*args)
        super(*args)
        @player_id ||= player_id

        res = stats_request('commonplayerinfo', 'PlayerID' => player_id)

        @data = res['resultSets']
      end

      def info
        create_stats_hash(@data[0])
      end

      def headline_stats
        create_stats_hash(@data[1])
      end
    end
  end
end
