module NbaRb
  module Team
    class BaseClass
      include StatsHash
      include Initializable
      include StatsRequest
    end

    require_relative './game/boxscore'
    require_relative './game/boxscore_advanced'
    require_relative './game/boxscore_four_factors'
    require_relative './game/boxscore_misc'
    require_relative './game/boxscore_scoring'
    require_relative './game/boxscore_usage'
    require_relative './game/play_by_play'
  end
end
