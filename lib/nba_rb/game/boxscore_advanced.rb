module NbaRb
  module Game
    class BoxscoreAdvanced < Boxscore
      @endpoint = 'boxscoreadvancedv2'

      def players_advanced
        create_stats_hash(@data[13])
      end

      def team_advanced
        create_stats_hash(@data[14])
      end
    end
  end
end
