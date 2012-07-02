module SportsPresentation
  module Api
    class Grouping < Base

      attr_reader :groupings, :competitions, :contests, :name, :uid, :url, :link_type

      def parse_response(grouping)
        @name = grouping.at("name")
        @uid = grouping.at(":uid")
        @url = grouping.at(":self")
        @link_type = grouping.at(":type")
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