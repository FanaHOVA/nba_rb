module NbaRb
  module Game
    class Boxscore < BaseClass
      @endpoint = 'boxscoretraditionalv2'

      class << self
        attr_reader :endpoint
      end

      def endpoint
        self.class.endpoint
      end

      attr_accessor :game_id,
                    :range_type,
                    :start_period,
                    :end_period,
                    :start_range,
                    :end_range,
                    :data

      def initialize(*args)
        super(*args)

        @range_type ||= NbaRb::RangeType.default
        @start_period ||= NbaRb::Period.default
        @end_period ||= NbaRb::Period.default
        @start_range ||= NbaRb::StartRange.default
        @end_range ||= NbaRb::EndRange.default

        res = stats_request(endpoint, 'GameID' => game_id,
                                      'RangeType' => range_type,
                                      'StartPeriod' => start_period,
                                      'EndPeriod' => end_period,
                                      'StartRange' => start_range,
                                      'EndRange' => end_range)

        @data = res['resultSets']
      end

      def player_stats
        create_stats_hash(@data[0])
      end

      def team_stats
        create_stats_hash(@data[1])
      end

      def team_starter_bench_stats
        create_stats_hash(@data[2])
      end
    end
  end
end
