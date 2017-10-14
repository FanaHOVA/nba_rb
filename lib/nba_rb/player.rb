module NbaRb
  module Player
    class BaseClass
      include Initializable
      include StatsRequest
      include StatsHash

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
