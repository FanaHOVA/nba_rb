module NbaRb
  module Team
    class GeneralSplits < Dashboard
      @endpoint = 'teamdashboardbygeneralsplits'

      def by_location
        create_stats_hash(@data[1])
      end

      def wins_losses
        create_stats_hash(@data[2])
      end

      def monthly
        create_stats_hash(@data[3])
      end

      def pre_post_all_star
        create_stats_hash(@data[4])
      end

      def days_rest
        create_stats_hash(@data[5])
      end
    end
  end
end
