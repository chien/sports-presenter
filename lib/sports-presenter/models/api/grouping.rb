module SportsPresentation
  module Api
    class Grouping < Base

      attr_reader :groupings, :competitions, :contests, :name, :uid

      def parse_response(grouping)
        @name = grouping.at("name")
        @uid = grouping.at(":uid")
        @groupings = [] #grouping["groupings"].collect {|group| Api::Grouping.new group} if grouping["groupings"]

        @competitions = []#PlayupTypes.lazyref("competitions")
        @contests = PlayupTypes.lazyref("contests")
      end

      def self.find(slug)
        new SportsApiClient.fetch("/groupings/#{slug}")
      end

    end
  end
end