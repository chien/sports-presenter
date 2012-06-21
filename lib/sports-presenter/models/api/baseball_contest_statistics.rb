module SportsPresentation
  module Api
    class BaseballContestStatistics < Base
      STATS = %w( runs errors hits )

      attr_reader *STATS
      attr_reader :team_id, :display_name, :innings, :players

      def parse_response(stats)
        STATS.each do |stat|
          # This funkyness is to ensure a missing value is set to zero.
          val = stats[stat].to_s
          val = (val =~ /0\./) ? val.to_f : val.to_i

          instance_variable_set("@#{stat}", val)
        end

        @team_id = stats.at("team.:self") =~ /\/teams\/(\d+)$/ ? $1 : nil
        @display_name = stats.at("team.display_name")
        @innings = stats.at("innings")
        @players = stats.at("players")
      end

    end
  end
end