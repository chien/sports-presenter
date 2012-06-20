module SportsPresentation
  module Api
    class ContestDetails < Base

      attr_reader :home_team, :away_team

      def parse_response(contest_details)
        klass = SportsPresentation::Api.const_get(contest.sport + "ContestStatistics")
        @home_team = klass.new contest_details["scores"].first
        @away_team = klass.new contest_details["scores"].last
      end

      def self.find(id)
        contest = SportsApiClient.fetch("/contest_details/#{id}")
        new(contest)
      end

    end
  end
end