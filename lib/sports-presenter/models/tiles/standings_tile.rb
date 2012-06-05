module SportsPresentation
  module Tiles
    class StandingsTile < SolidTileDisplay
      def initialize
        super title: :competition_standings, background_image: {
          low: "/tiles/standings/football/low_140_88.png",
          medium: "/tiles/standings/football/medium_222_132.png",
          high: "/tiles/standings/football/high_296_176.png"          
        }
      end
    end
  end
end