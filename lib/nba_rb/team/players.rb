module NbaRb
  module Team
    class Players < Dashboard
      @endpoint = 'teamplayerdashboard'

      def season_totals
        create_stats_hash(@data[1])
      end
    end
  end
end
