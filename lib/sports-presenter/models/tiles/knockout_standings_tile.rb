module SportsPresentation
  module Tiles
    class KnockoutStandingsTile < SolidTileDisplay
      def initialize
        super title: :knockout_standings, background_image: {
          low: "/tiles/knockout-standings/football/low_148_88.png",
          medium: "/tiles/knockout-standings/football/medium_222_132.png",
          high: "/tiles/knockout-standings/football/high_296_176.png"          
        }, background_color: "#8CB5B8"
      end
    end
  end
end