module SportsPresentation
  module Api
    class Competition < Base
      attr_reader :name, :uid, :live_contests
      def parse_response(competition)
        @name = competition["name"]
        @uid = competition[":uid"]
        @live_contests = competition["live_contests"]
        @current_stage = PlayupTypes.lazyref competition.at("current_stage")
      end

      def self.find(id)
        competition = SportsApiClient.fetch("/competitions/#{id}")
        new(competition)
      end

      def self.all
        competitions = SportsApiClient.fetch("/competitions/")
        Api::Collection.new(competitions)
      end

      def current_stage
        if @current_stage.respond_to?(:fetch) 
          @current_stage = @current_stage.fetch
        else
          @current_stage
        end
      end

    end
  end
end