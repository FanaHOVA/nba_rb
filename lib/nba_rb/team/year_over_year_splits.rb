module NbaRb
  module Team
    class YearOverYearSplits < Dashboard
      @endpoint = 'teamdashboardbyyearoveryear'

      def by_year
        create_stats_hash(@data[1])
      end
    end
  end
end
