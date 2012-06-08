module SportsPresentation
  module Api
    class FootballContestStatistics < Base
      STATS = %w( score saves yellow_cards red_cards crosses fouls offsides corner_kicks tackles passes possession_percentage )

      attr_reader *STATS
      attr_reader :team_id, :display_name, :shot_statistics

      def parse_response(stats)
        STATS.each do |stat|
          # This funkyness is to ensure a missing value is set to zero.
          val = stats[stat].to_s
          val = (val =~ /0\./) ? val.to_f : val.to_i

          instance_variable_set("@#{stat}", val)
        end

        @shot_statistics = stats.at("shot_statistics")

        @team_id = stats.at("team.:self") =~ /\/teams\/(\d+)$/ ? $1 : nil
        @display_name = stats.at("team.display_name")
      end

    end
  end
end