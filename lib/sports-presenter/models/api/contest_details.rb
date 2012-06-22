module SportsPresentation
  module Api
    class ContestDetails < Base

      attr_reader :home_team, :away_team

      def parse_response(contest_details)
        klass = SportsPresentation::Api.const_get( sport(contest_details)+ "ContestStatistics")
        @home_team = klass.new contest_details["scores"].first rescue nil
        @away_team = klass.new contest_details["scores"].last rescue nil
      end

      def self.find(id)
        contest = SportsApiClient.fetch("/contest_details/#{id}")
        new(contest)
      end
      
      def sport(contest_details)
        contest_details[":type"].split("+").first.split("/").last.split(".").last.capitalize
      end
      
    end
  end
end