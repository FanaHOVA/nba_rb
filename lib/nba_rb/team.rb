module NbaRb
  module Team
    class BaseClass
      include StatsHash
      include Initializable
      include StatsRequest
    end

    require_relative './team/dashboard'
    require_relative './team/clutch_splits'
    require_relative './team/common_roster'
    require_relative './team/game_logs'
    require_relative './team/general_splits'
    require_relative './team/in_game_splits'
    require_relative './team/last_n_games_splits'
    require_relative './team/lineups'
    require_relative './team/list'
    require_relative './team/opponent_splits'
    require_relative './team/pass_tracking'
    require_relative './team/performance_splits'
    require_relative './team/player_on_off_detail'
    require_relative './team/player_on_off_summary'
    require_relative './team/players'
    require_relative './team/rebound_tracking'
    require_relative './team/seasons'
    require_relative './team/shooting_splits'
    require_relative './team/shot_tracking'
    require_relative './team/summary'
    require_relative './team/vs_player'
    require_relative './team/year_over_year_splits'
  end
end
