module NbaRb
  module Team
    class OpponentSplits < Dashboard
      @endpoint = 'teamdashboardbyopponent'

      def by_conference
        create_stats_hash(@data[1])
      end

      def by_division
        create_stats_hash(@data[2])
      end

      def by_opponent
        create_stats_hash(@data[3])
      end
    end
  end
end
