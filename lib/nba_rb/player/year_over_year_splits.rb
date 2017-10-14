module NbaRb
  module Player
    class YearOverYearSplits < NbaRb::Player::Dashboard
      @endpoint = 'playerdashboardbyyearoveryear'

      def splits_by_year
        create_stats_hash(@data[1])
      end

      def by_year(year)
        splits_by_year.each do |hash|
          return hash if hash['GROUP_VALUE'].include? year
        end
      end
    end
  end
end
