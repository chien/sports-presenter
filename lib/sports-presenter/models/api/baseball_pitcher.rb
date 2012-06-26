module SportsPresentation
  module Api
    class BaseballPitcher < Base
      STATS = %w( sequence hits runs earned_runs walks strike_outs homeruns )

      attr_reader *STATS
      attr_reader :display_name, :earned_run_average, :innings

      def parse_response(stats)
        STATS.each do |stat|
          # This funkyness is to ensure a missing value is set to zero.
          val = stats[stat].to_s
          val = (val =~ /0\./) ? val.to_f : val.to_i

          instance_variable_set("@#{stat}", val)
        end
        
        @display_name = stats["first_name"] + " " + stats["last_name"]
        @earned_run_average = stats["earned_run_average"]
        @innings = stats["innings"]
      end

    end
  end
end