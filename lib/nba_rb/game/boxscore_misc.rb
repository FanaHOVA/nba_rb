module NbaRb
  module Game
    class BoxscoreMisc < Boxscore
      @endpoint = 'boxscoremiscv2'

      def endpoint
        self.class.endpoint
      end

      def players_misc
        create_stats_hash(@data[0])
      end

      def team_misc
        create_stats_hash(@data[1])
      end
    end
  end
end
