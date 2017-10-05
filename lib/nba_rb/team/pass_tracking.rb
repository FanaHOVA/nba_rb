module NbaRb
  module Team
    class PassTracking < Dashboard
      @endpoint = 'teamdashptpass'

      def passes_made
        create_stats_hash(@data[0])
      end

      def passes_recieved
        create_stats_hash(@data[1])
      end
    end
  end
end
