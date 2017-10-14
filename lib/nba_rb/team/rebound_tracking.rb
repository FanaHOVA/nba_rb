module NbaRb
  module Team
    class ReboundTracking < Dashboard
      @endpoint = 'teamdashptreb'

      def shot_type_rebounding
        create_stats_hash(@data[1])
      end

      def contested_rebounding
        create_stats_hash(@data[2])
      end

      def shot_distance_rebounding
        create_stats_hash(@data[3])
      end

      def rebound_distance_rebounding
        create_stats_hash(@data[4])
      end
    end
  end
end
