module NbaRb
  module Player
    class ClutchSplits < NbaRb::Player::Dashboard
      @endpoint = 'playerdashboardbyclutch'

      def last5min_deficit_5point
        ''"
        Results in last 5 minutes <= 5 points
        "''
        create_stats_hash(@data[1])
      end

      def last3min_deficit_5point
        ''"
        Results in last 5 minutes <= 5 points
        "''
        create_stats_hash(@data[2])
      end

      def last1min_deficit_5point
        ''"
        Results in last 5 minutes <= 5 points
        "''
        create_stats_hash(@data[3])
      end

      def last30sec_deficit_3point
        ''"
        Results in last 5 minutes <= 5 points
        "''
        create_stats_hash(@data[4])
      end

      def last10sec_deficit_3point
        ''"
        Results in last 5 minutes <= 5 points
        "''
        create_stats_hash(@data[5])
      end

      def last5min_plusminus_5point
        ''"
        Last 5 minutes +/= 5 points
        "''
        create_stats_hash(@data[6])
      end

      def last3min_plusminus_5point
        ''"
        Last 3 minutes +/= 5 points
        "''
        create_stats_hash(@data[7])
      end

      def last1min_plusminus_5point
        ''"
        Last 1 minutes +/= 5 points
        "''
        create_stats_hash(@data[8])
      end

      def last30sec_plusminus_5point
        ''"
        Last 30 seconds +/= 3 points
        "''
        create_stats_hash(@data[9])
      end
    end
  end
end
