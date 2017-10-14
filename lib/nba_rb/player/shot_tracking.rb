module NbaRb
  module Player
    class ShotTracking < PlayerDashboard
      @endpoint = 'playerdashptshots'

      def general_shooting
        create_stats_hash(@data[1])
      end

      def shot_clock_shooting
        create_stats_hash(@data[2])
      end

      def dribble_shooting
        create_stats_hash(@data[3])
      end

      def closest_defender_shooting
        create_stats_hash(@data[4])
      end

      def closest_defender_shooting_long
        create_stats_hash(@data[5])
      end

      def touch_time_shooting
        create_stats_hash(@data[6])
      end
    end
  end
end
