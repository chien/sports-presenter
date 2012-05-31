module SportsPresentation
  module Tiles
    class ContestStatisticsTile < SolidTileDisplay

      def initialize
        super title: "Statistics", background_image: {
          low: "http://sdimages.playupgp.com/sport-logos/sport-8_1333601532_148x88.jpeg",
          medium: "http://sdimages.playupgp.com/sport-logos/sport-8_1333601532_222x132.jpeg",
          high: "http://sdimages.playupgp.com/sport-logos/sport-8_1333601532_296x176.jpeg"
        }
      end

    end
  end
end