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

    end
  end
end