module NbaRb
  module Player
    class BaseClass
      include Initializable
      include StatsRequest
      include StatsHash

      require_relative './player/dashboard'
      require_relative './player/career'
      require_relative './player/clutch_splits'
      require_relative './player/defense_tracking'
      require_relative './player/game_logs'
      require_relative './player/general_splits'
      require_relative './player/in_game_splits'
      require_relative './player/last_n_games_splits'
      require_relative './player/list'
      require_relative './player/opponent_splits'
      require_relative './player/pass_tracking'
      require_relative './player/performance_splits'
      require_relative './player/player_vs_player'
      require_relative './player/profile'
      require_relative './player/rebound_log_tracking'
      require_relative './player/shooting_splits'
      require_relative './player/rebound_tracking'
      require_relative './player/shooting_splits'
      require_relative './player/shot_log_tracking'
      require_relative './player/shot_tracking'
      require_relative './player/summary'
      require_relative './player/year_over_year_splits'

      attr_accessor :first_name,
                    :last_name,
                    :only_current,
                    :data

      def initialize(*args)
        super(*args)
        last_formatted = last_name.downcase.capitalize
        first_formatted = first_name.downcase.capitalize

        name = "#{last_formatted}, #{first_formatted}"
        list = PlayerList.new.info

        list['rowSet'].each do |player|
          @data = player if player[1] == name
        end
      end

      def id
        @data[0]
      end

      def player_code
        @data[5]
      end

      def rostered?
        @data[2].zero?
      end

      def team_id
        @data[6]
      end

      def team_name
        @data[7] + ' ' + @data[8]
      end

      def team_abbreviation
        @data[9]
      end

      def team_code
        @data[10]
      end
    end
  end
end
