module SportsPresentation
  module Tiles
    class GroupingTile < SolidTileDisplay
      def initialize(name, uid)
        @uid = uid
        super title: name, background_image: {
          low: "/tiles/standings/football/low_148_88.png",
          medium: "/tiles/standings/football/medium_222_132.png",
          high: "/tiles/standings/football/high_296_176.png"          
        }, background_color: "#8CB5B8"
      end

    end
  end
end