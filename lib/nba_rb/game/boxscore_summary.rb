module NbaRb
  module Game
    class BoxscoreSummary < BaseClass
      @endpoint = 'boxscoresummaryv2'

      class << self
        attr_reader :endpoint
      end

      def endpoint
        self.class.endpoint
      end

      attr_accessor :game_id,
                    :season,
                    :season_type,
                    :range_type,
                    :start_period,
                    :end_period,
                    :start_range,
                    :end_range,
                    :data

      def initialize(*args)
        super(*args)

        @season ||= NbaRb::CURRENT_SEASON
        @season_type ||= NbaRb::SeasonType.default
        @range_type ||= NbaRb::RangeType.default
        @start_period ||= NbaRb::Period.default
        @end_period ||= NbaRb::Period.default
        @start_range ||= NbaRb::StartRange.default
        @end_range ||= NbaRb::EndRange.default

        res = stats_request(endpoint, 'GameID' => game_id,
                                      'Season' => season,
                                      'SeasonType' => season_type,
                                      'RangeType' => range_type,
                                      'StartPeriod' => start_period,
                                      'EndPeriod' => end_period,
                                      'StartRange' => start_range,
                                      'EndRange' => end_range)

        @data = res['resultSets']
      end

      def game_summary
        create_stats_hash(@data[0])
      end

      def other_stats
        create_stats_hash(@data[1])
      end

      def officials
        create_stats_hash(@data[2])
      end

      def inactive_players
        create_stats_hash(@data[3])
      end

      def game_info
        create_stats_hash(@data[4])
      end

      def line_score
        create_stats_hash(@data[5])
      end

      def last_meeting
        create_stats_hash(@data[6])
      end

      def season_series
        create_stats_hash(@data[7])
      end

      def available_video
        create_stats_hash(@data[8])
      end
    end
  end
end
