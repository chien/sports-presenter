module SportsPresentation
  module Tiles
    class ContestTile < SolidTileDisplay
      def initialize(name, uid, is_live)
        @uid = uid
        super live: is_live, title: name, background_image: {
          low: "/tiles/standings/football/low_148_88.png",
          medium: "/tiles/standings/football/medium_222_132.png",
          high: "/tiles/standings/football/high_296_176.png"          
        }, background_color: "#8CB5B8"
      end

    end
  end
end