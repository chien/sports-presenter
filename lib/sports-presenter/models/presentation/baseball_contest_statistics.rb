module SportsPresentation
  module Presentation
    
    class BaseballContestStatistics

      attr_reader :events

      def initialize(contest)
        super
        @statistics = contest.statistics
      end

      def valid?
        @statistics && @statistics.home_team && @statistics.away_team
      end

      def home_team
        OpenStruct.new(
          :display_name => @statistics.home_team.display_name, 
          :score => @contest.home_team_score
          )
      end

      def away_team
        OpenStruct.new(
          :display_name => @statistics.away_team.display_name, 
          :score => @contest.away_team_score
          )
      end


    end
  end
end