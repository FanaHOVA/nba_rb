module NbaRb
  module Team
    class InGamesSplits < Dashboard
      @endpoint = 'teamdashboardbygamesplits'

      def by_half
        create_stats_hash(@data[1])
      end

      def by_period
        create_stats_hash(@data[2])
      end

      def by_score_margin
        create_stats_hash(@data[3])
      end

      def by_actual_margin
        create_stats_hash(@data[4])
      end
    end
  end
end
