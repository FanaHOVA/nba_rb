module NbaRb
  module Player
    class PassTracking < NbaRb::Player::Dashboard
      @endpoint = 'playerdashptpass'

      def passes_made
        create_stats_hash(@data[0])
      end

      def passes_recieved
        create_stats_hash(@data[1])
      end
    end
  end
end
