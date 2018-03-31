module NbaRb
  module Game
    class Scoreboard < BaseClass
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
        @game_date ||= Date.today.to_s.tr('-', ' ')
        @day_offset ||= 0

        res = stats_request(endpoint, 'LeagueID' => league_id,
                                      'gameDate' => game_date,
                                      'DayOffset' => day_offset)

        @data = res['resultSets']
      end

      def arena_and_tv_info
        create_stats_hash(@data[0])
      end

      def matchup_teams_info
        # Each team has its own array of info. The second element in the array
        # is the # of the game they play in. Example:
        # [date_of_game, 1, '...', 'Charlotte']
        # [date_of_game, 1, '...', 'Washington']
        # The first game is Charlotte @ Washington
        create_stats_hash(@data[1])
      end

      def series_standings
        create_stats_hash(@data[2])
      end

      def last_meeting
        create_stats_hash(@data[3])
      end

      def eastern_conference_standings_today
        create_stats_hash(@data[4])
      end

      def western_conference_standings_today
        create_stats_hash(@data[5])
      end
    end
  end
end
