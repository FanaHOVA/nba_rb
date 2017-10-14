module NbaRb
  module Player
    class PerformanceSplits < PlayerDashboard
      @endpoint = 'playerdashboardbyteamperformance'

      def score_differential
        create_stats_hash(@data[1])
      end

      def points_scored
        create_stats_hash(@data[2])
      end

      def points_against
        create_stats_hash(@data[3])
      end
    end
  end
end
