module SportsPresentation
  module Presentation
    class FootballEvents
    end
    
    class FootballContestStatistics < FootballEvents

      attr_reader :events

      def initialize(contest)
        super
        @statistics = contest.statistics
      end

      def valid?
        @statistics && @statistics.home_team && @statistics.away_team
      end

      def home_team
        @statistics.home_team
      end

      def away_team
        @statistics.away_team
      end

      def competition_name
        @contest.competition_name
      end

      def round_name
        @contest.round_name
      end

    end
  end
end