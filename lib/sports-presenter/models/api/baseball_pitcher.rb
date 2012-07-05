module SportsPresentation
  module Api
    class BaseballPitcher < Base
      STATS = %w( sequence hits runs earned_runs walks strike_outs homeruns )

      attr_reader *STATS
      attr_reader :first_name, :last_name, :earned_run_average, :innings, :id
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
        @earned_run_average = stats["earned_run_average"]
        @innings = stats["innings"]
      end

    end
  end
end