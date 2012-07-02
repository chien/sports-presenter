module SportsPresentation
  module Api
    class Grouping < Base

      attr_reader :groupings, :competitions, :contests, :name, :uid, :url, :link_type, :slug

      def parse_response(grouping)
        @name = grouping.at("name")
        @uid = grouping.at(":uid")
        @url = grouping.at(":self")
        @link_type = grouping.at(":type")
        
        uid_array = @uid.match(Api::Grouping.uid_regex)
        @slug = uid_array[:slug]

        @groupings = []
        @groupings = grouping["groupings"].collect do |group| 
          PlayupTypes.lazyref group
        end if grouping["groupings"]
        
        @competitions, @contests = [], []
        @competitions = PlayupTypes.lazyref(grouping.at("competitions")).fetch unless grouping["competitions"].nil?
        @contests = PlayupTypes.lazyref(grouping.at("contests")).fetch unless grouping["contests"].nil?
      end

      def self.find(slug)
        new SportsApiClient.fetch("/groupings/#{slug}")
      end

      def self.uid_regex
        /\-(?<slug>.*)\-(?<id>[\d+])/
      end
    end
  end
end