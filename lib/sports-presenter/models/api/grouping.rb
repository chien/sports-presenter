module SportsPresentation
  module Api
    class Grouping

      attr_reader :groupings, :competitions, :contests

      def parse_response(grouping)
        @groupings = grouping["groupings"]
        @competitions = []
        @contests = []
      end

      def self.find(slug)
        new SportsApiClient.fetch("/groupings/#{slug}")
      end

    end
  end
end