module NbaRb
  module Game
    class BoxscoreAdvanced < Boxscore
      @endpoint = 'boxscoreadvancedv2'

      def players_advanced
        create_stats_hash(@data[0])
      end

      def team_advanced
        create_stats_hash(@data[1])
      end
    end
  end
end
