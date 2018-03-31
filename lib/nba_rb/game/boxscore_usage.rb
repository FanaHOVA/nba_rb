module NbaRb
  module Game
    class BoxscoreUsage < Boxscore
      @endpoint = 'boxscoreusagev2'

      def endpoint
        self.class.endpoint
      end

      def players_usage
        create_stats_hash(@data[0])
      end

      def team_usage
        create_stats_hash(@data[1])
      end
    end
  end
end
