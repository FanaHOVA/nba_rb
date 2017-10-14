module NbaRb
  module Player
    class LastNGamesSplits < PlayerDashboard
      @endpoint = 'playerdashboardbylastngames'

      def last5
        create_stats_hash(@data[1])
      end

      def last10
        create_stats_hash(@data[2])
      end

      def last15
        create_stats_hash(@data[3])
      end

      def last20
        create_stats_hash(@data[4])
      end

      def gamenumber
        create_stats_hash(@data[5])
      end
    end
  end
end
