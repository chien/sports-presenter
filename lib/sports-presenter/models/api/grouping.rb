module SportsPresentation
  module Api
    class Grouping < Base

      attr_reader :groupings, :competitions, :contests, :name, :uid, :url

      def parse_response(grouping)
        @name = grouping.at("name")
        @uid = grouping.at(":uid")
        @url = grouping.at(":self")
        @groupings = []
        @groupings = grouping["groupings"].collect do |group| 
          PlayupTypes.lazyref group
        end if grouping["groupings"]

        @competitions = []#PlayupTypes.lazyref("competitions")
        @contests = PlayupTypes.lazyref("contests")
      end

      def self.find(slug)
        new SportsApiClient.fetch("/groupings/#{slug}")
      end

    end
  end
end