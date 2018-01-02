module NbaRb
  module Game
    class Hustle < NbaRb::Team::BaseClass
      @endpoint = 'hustlestatsboxscore'

      attr_accessor :game_id

      def initialize(*args)
        super(*args)

        res = stats_request(endpoint, 'GameID' => game_id)

        @data = res['resultSets']
      end

      def hustle_stats_available
        create_stats_hash(@data[0])
      end

      def hustle_stats_player_box_score
        create_stats_hash(@data[1])
      end

      def hustle_stats_team_box_score
        create_stats_hash(@data[2])
      end
    end
  end
end
