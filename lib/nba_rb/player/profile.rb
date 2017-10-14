module NbaRb
  module Player
    class Profile < NbaRb::Player::Career
      @endpoint = 'playerprofilev2'

      def season_highs
        create_stats_hash(@data[10])
      end

      def career_highs
        create_stats_hash(@data[11])
      end

      def next_game
        create_stats_hash(@data[12])
      end
    end
  end
end
