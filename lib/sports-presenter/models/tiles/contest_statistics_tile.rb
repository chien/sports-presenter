module SportsPresentation
  module Tiles
    class ContestStatisticsTile < PhotoTileDisplay

      def initialize
        super title: :contest_statistics, image: {
          low: "/tiles/statistics/football/low_140_88.png",
          medium: "/tiles/statistics/football/medium_222_132.png",
          high: "/tiles/statistics/football/high_296_176.png"
        }
      end

    end
  end
end