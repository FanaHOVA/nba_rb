module NbaRb
  module Team
    class LastNGamesSplits < Dashboard
      @endpoint = 'teamdashboardbylastngames'

      def last_5
        create_stats_hash(@data[1])
      end

      def last_10
        create_stats_hash(@data[2])
      end

      def last_15
        create_stats_hash(@data[3])
      end

      def last_20
        create_stats_hash(@data[4])
      end

      def game_number
        create_stats_hash(@data[5])
      end
    end
  end
end
