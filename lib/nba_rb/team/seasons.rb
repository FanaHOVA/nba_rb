module NbaRb
  module Team
    class Seasons
      attr_accessor :team_id,
                    :season_type,
                    :per_mode

      def initialize(*args)
        super(*args)

        @season_type ||= NbaRb::SeasonType.Default
        @per_mode ||= NbaRb::PerMode.Default

        res = stats_request('teamyearbyyearstats', 'TeamID' => team_id,
                                                   'SeasonType' => season_type,
                                                   'PerMode' => per_mode)

        @data = res['resultSets']
      end

      def info
        create_stats_hash(@data[1])
      end
    end
  end
end
