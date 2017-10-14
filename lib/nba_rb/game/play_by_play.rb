module NbaRb
  module Game
    class PlayByPlay < NbaRb::Team::BaseClass
      include Initializable
      include StatsRequest
      include StatsHash

      def initialize(*args)
        super(*args)

        @start_period ||= NbaRb::Period.default
        @end_period ||= NbaRb::Period.default

        res = stats_request('playbyplay', 'GameID' => @game_id,
                                          'StartPeriod' => start_period,
                                          'EndPeriod' => end_period)

        @data = res['resultSets']
      end

      def info
        create_stats_hash(@data[0])
      end

      def available_video
        create_stats_hash(@data[1])
      end
    end
  end
end
