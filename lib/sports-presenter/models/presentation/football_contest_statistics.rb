module SportsPresentation
  module Presentation
    class FootballContestStatistics

      def initialize(contest_data, event_data)
        @contest_data, @event_data = contest_data, event_data
      end

      def self.fetch(contest_id)
        contest_data = SportsApiClient.fetch("/contest_details/#{contest_id}")
        events = SportsApiClient.fetch("/contests/#{contest_id}/events")
        new(contest_data, events)
      end

      def home_team_statistics
        
      end

      def away_team_statistics
        
      end

      def goal_rundown
        
      end

    end
  end
end