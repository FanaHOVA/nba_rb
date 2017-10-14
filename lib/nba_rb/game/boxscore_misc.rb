module NbaRb
  module Game
    class BoxscoreMisc < Boxscore
      @endpoint = 'boxscoremiscv2'

      def endpoint
        self.class.endpoint
      end

      def players_misc
        create_stats_hash(@data[13])
      end

      def team_misc
        create_stats_hash(@data[14])
      end
    end
  end
end
