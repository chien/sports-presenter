module SportsPresentation
  module Api
    class ContestDetails

      attr_reader :home_team, :away_team

      def initialize(contest_details)
        @home_team = FootballContestStatistics.new(contest_details["scores"].first)
        @away_team = FootballContestStatistics.new(contest_details["scores"].last)
      end

      def self.find(id)
        contest = SportsApiClient.fetch("/contest_details/#{id}")
        new(contest)
      end

    end
  end
end