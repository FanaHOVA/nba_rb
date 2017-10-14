module NbaRb
  module Player
    class Career
      include Initializable
      include StatsRequest
      include StatsHash

      class << self
        attr_reader :endpoint
      end

      def endpoint
        self.class.endpoint
      end

      attr_accessor :player_id,
                    :league_id,
                    :per_mode,
                    :data

      def initialize(*args)
        super(*args)

        @per_mode ||= NbaRb::PerMode.per_game
        @league_id ||= NbaRb::League.NBA

        res = stats_request('playercareerstats', 'PlayerID' => player_id,
                                                 'LeagueID' => league_id,
                                                 'PerMode' => per_mode)

        @data = res['resultSets']
      end

      def regular_season_totals
        create_stats_hash(@data[0])
      end

      def season_totals_by_year(year)
        regular_season_totals.each do |hash|
          return hash if hash['SEASON_ID'].include? year
        end
      end

      def regular_season_career_totals
        create_stats_hash(@data[1])
      end

      def post_season_totals
        create_stats_hash(@data[2])
      end

      def post_season_totals_by_year(year)
        post_season_totals.each do |hash|
          return hash if hash['SEASON_ID'].include? year
        end
      end

      def post_season_career_totals
        create_stats_hash(@data[3])
      end

      def all_star_season_totals
        create_stats_hash(@data[4])
      end

      def all_star_season_totals_by_year(year)
        all_star_season_totals.each do |hash|
          return hash if hash['SEASON_ID'].include? year
        end
      end

      def career_all_star_season_totals
        create_stats_hash(@data[5])
      end

      def college_season_totals
        create_stats_hash(@data[6])
      end

      def college_season_totals_by_year(year)
        college_season_totals.each do |hash|
          return hash if hash['SEASON_ID'].include? year
        end
      end

      def career_college_season_totals
        create_stats_hash(@data[7])
      end

      def regular_season_rankings
        create_stats_hash(@data[8])
      end

      def regular_season_rankings_by_year(year)
        regular_season_rankings.each do |hash|
          return hash if hash['SEASON_ID'].include? year
        end
      end

      def post_season_rankings
        create_stats_hash(@data[9])
      end

      def post_season_rankings_by_year(year)
        post_season_rankings.each do |hash|
          return hash if hash['SEASON_ID'].include? year
        end
      end
    end
  end
end
