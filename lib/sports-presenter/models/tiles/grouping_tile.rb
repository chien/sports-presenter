module SportsPresentation
  module Tiles
    class GroupingTile < SolidTileDisplay
      attr_reader :uid, :name, :link_type
      def initialize(name, uid, link_type, slug)
        @uid = uid
        @name = name
        @link_type = link_type
        super title: name, background_image: {
          low: "/tiles/grouping/#{slug}/low_148_88.png",
          medium: "/tiles/grouping/#{slug}/medium_222_132.png",
          high: "/tiles/grouping/#{slug}/high_296_176.png"          
        }, background_color: "#8CB5B8"
      end

    end
  end
end