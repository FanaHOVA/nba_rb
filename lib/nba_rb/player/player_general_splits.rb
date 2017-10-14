module NbaRb
  module Player
    class GeneralSplits < PlayerDashboard
      @endpoint = 'playerdashboardbygeneralsplits'

      def location
        create_stats_hash(@data[1])
      end

      def home
        location[0]
      end

      def away
        location[1]
      end

      def win_losses
        create_stats_hash(@data[2])
      end

      def in_wins
        win_losses[0]
      end

      def in_losses
        win_losses[1]
      end

      def by_month
        create_stats_hash(@data[3])
      end

      def in_october
        by_month[0]
      end

      def in_november
        by_month[1]
      end

      def in_december
        by_month[2]
      end

      def in_january
        by_month[3]
      end

      def in_february
        by_month[4]
      end

      def in_march
        by_month[5]
      end

      def in_april
        by_month[6]
      end

      def in_may
        by_month[7]
      end

      def in_june
        by_month[8]
      end

      def pre_post_all_star
        create_stats_hash(@data[4])
      end

      def pre_all_star
        pre_post_all_star[0]
      end

      def post_all_star
        pre_post_all_star[1]
      end

      def starting_position
        create_stats_hash(@data[5])
      end

      def as_starter
        starting_position[0]
      end

      def as_bench
        starting_position[1]
      end

      def days_rest
        create_stats_hash(@data[6])
      end

      def zero_rest_days
        days_rest[0]
      end

      def one_rest_day
        days_rest[1]
      end

      def two_rest_days
        days_rest[2]
      end

      def three_rest_days
        days_rest[3]
      end

      def four_rest_days
        days_rest[4]
      end

      def six_plus_rest_days
        days_rest[5]
      end
    end
  end
end
