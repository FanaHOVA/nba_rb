module NbaRb
  module Team
    class PlayerOnOffSummary < Dashboard
      @endpoint = 'teamplayeronoffsummary'

      def on_court
        create_stats_hash(@data[1])
      end

      def off_court
        create_stats_hash(@data[2])
      end
    end
  end
end
