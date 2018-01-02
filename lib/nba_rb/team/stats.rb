module NbaRb
  module Team
    class Stats < Dashboard
      @endpoint = 'leaguedashteamstats'

      attr_accessor :league_id,
                    :data

      def initialize(*args)
        super(*args)
      end

      def overall
        create_stats_hash(@data[0])
      end
    end
  end
end
