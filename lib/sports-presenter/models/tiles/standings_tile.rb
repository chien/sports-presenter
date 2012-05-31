module SportsPresentation
  module Tiles
    class StandingsTile < SolidTileDisplay
      BACKGROUND_IMAGE = ""

      def initialize
        super title: "Standings", background_image: BACKGROUND_IMAGE
      end
    end
  end
end