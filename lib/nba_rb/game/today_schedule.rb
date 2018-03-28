module NbaRb
  module Game
    class TodaySchedule < NbaRb::Team::BaseClass
      @endpoint = 'scoreboardV2'

      class << self
        attr_reader :endpoint
      end

      def endpoint
        self.class.endpoint
      end

      attr_accessor :league_id,
                    :game_date,
                    :day_offset,
                    :data

      def initialize(*args)
        super(*args)

        @league_id ||= NbaRb::League.default
        @game_date ||= Date.current.to_s.tr('-', ' ')
        @day_offset ||= 0

        res = stats_request(endpoint, 'LeagueID' => league_id,
                                      'gameDate' => game_date,
                                      'DayOffset' => day_offset)

        @data = res['resultSets']
      end
    end
  end
end
