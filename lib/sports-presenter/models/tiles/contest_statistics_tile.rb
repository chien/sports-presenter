module SportsPresentation
  module Tiles
    class ContestStatisticsTile < PhotoTileDisplay

      def initialize
        super title: :contest_statistics, image: {
          low: "/tiles/statistics/all/low_148_88.png",
          medium: "/tiles/statistics/all/medium_222_132.png",
          high: "/tiles/statistics/all/high_296_176.png"
        }
      end

    end
  end
end