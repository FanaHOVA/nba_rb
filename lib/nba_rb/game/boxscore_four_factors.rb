module NbaRb
  module Game
    class BoxscoreFourFactors < Boxscore
      @endpoint = 'boxscorefourfactorsv2'

      def endpoint
        self.class.endpoint
      end

      def players_four_factors
        create_stats_hash(@data[13])
      end

      def team_four_factors
        create_stats_hash(@data[14])
      end
    end
  end
end
