module NbaRb
  module Player
    class InGameSplits < NbaRb::Player::Dashboard
      @endpoint = 'playerdashboardbygamesplits'

      def by_half
        create_stats_hash(@data[1])
      end

      def first_half
        by_half[0]
      end

      def second_half
        by_half[1]
      end

      def by_period
        create_stats_hash(@data[2])
      end

      def first_quarter
        by_period[0]
      end

      def second_quarter
        by_period[1]
      end

      def third_quarter
        by_period[2]
      end

      def fourth_quarter
        by_period[3]
      end

      def by_score_margin
        create_stats_hash(@data[3])
      end

      def tied_games
        by_score_margin[0]
      end

      def close_games
        by_score_margin[1]
      end

      def by_actual_margin
        create_stats_hash(@data[4])
      end
    end
  end
end
