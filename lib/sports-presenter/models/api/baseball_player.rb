module SportsPresentation
  module Api
    class BaseballPlayer < Base
      STATS = %w( runs homeruns singles doubles triples walks rbi stolen_bases at_bats strike_outs batting_average )

      attr_reader *STATS
      attr_reader :display_name, :hits

      def parse_response(stats)
        STATS.each do |stat|
          # This funkyness is to ensure a missing value is set to zero.
          val = stats[stat].to_s
          val = (val =~ /0\./) ? val.to_f : val.to_i

          instance_variable_set("@#{stat}", val)
        end
        
        @display_name = stats["first_name"] + " " + stats["last_name"]
        @hits = @singles + @doubles + @triples + @homeruns
      end

    end
  end
end