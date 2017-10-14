module NbaRb
  module Player
    class OpponentSplits < NbaRb::Player::Dashboard
      @endpoint = 'playerdashboardbyopponent'

      def by_conference
        create_stats_hash(@data[1])
      end

      def vs_east
        by_conference[0]
      end

      def vs_west
        by_conference[1]
      end

      def by_division
        create_stats_hash(@data[2])
      end

      def vs_division(division)
        by_division.each do |hash|
          return hash if hash['GROUP_VALUE'].downcase.include? division.downcase
        end
      end

      def by_opponent
        create_stats_hash(@data[3])
      end

      def vs_team(team)
        by_opponent.each do |hash|
          return hash if hash['GROUP_VALUE'].downcase.include? team.downcase
        end
      end
    end
  end
end
