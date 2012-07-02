module SportsPresentation
  module Api
    class BaseballPlayer < Base
      STATS = %w( runs homeruns singles doubles triples walks rbi stolen_bases at_bats strike_outs batting_average )

      attr_reader *STATS
      attr_reader :first_name, :last_name, :hits, :id
      attr_accessor :display_name
      
      def parse_response(stats)
        STATS.each do |stat|
          # This funkyness is to ensure a missing value is set to zero.
          val = stats[stat].to_s
          val = (val =~ /0\./) ? val.to_f : val.to_i

          instance_variable_set("@#{stat}", val)
        end
        @first_name = stats["first_name"]
        @last_name = stats["last_name"]
        @id = stats[":uid"]
        @hits = @singles + @doubles + @triples + @homeruns
      end

    end
  end
end