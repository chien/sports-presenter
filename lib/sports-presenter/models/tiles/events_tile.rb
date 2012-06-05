module SportsPresentation
  module Tiles
    class EventsTile < SolidTileDisplay

      def initialize
        super title: :contest_events, background_image: {
          low: "/tiles/events/football/low_140_88.png",
          medium: "/tiles/events/football/medium_222_132.png",
          high: "/tiles/events/football/high_296_176.png"          
        }
      end

    end
  end
end