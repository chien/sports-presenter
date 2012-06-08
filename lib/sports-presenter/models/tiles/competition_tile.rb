module SportsPresentation
  module Tiles
    class CompetitionTile < PhotoTileDisplay
      attr_accessor :uid
      def initialize(name, uid, live_contests)
        @uid = uid
        is_live = live_contests > 0
        super live: is_live, title: name, image: images
      end

      def image_cache_key
        "tile-#{uid}"
      end

      def has_special_image?
        return Thread.current[image_cache_key] unless Thread.current[image_cache_key].nil?

        Thread.current[image_cache_key] = begin
          RestClient.get(File.join(SportsPresentation.assets_host,"tiles/statistics/#{uid}_low_148_88.png")).code == 200
        rescue
          false
        end        
      end

      def images

        if has_special_image?
          {
            low: "/tiles/statistics/#{uid}_low_148_88.png",
            medium: "/tiles/statistics/#{uid}_medium_222_132.png",
            high: "/tiles/statistics/#{uid}_high_296_176.png"
          }
        else
          {
            low: "/tiles/competitions/defaults/low_148_88.png",
            medium: "/tiles/competitions/defaults/medium_222_132.png",
            high: "/tiles/competitions/defaults/high_296_176.png"
          }
        end
      end

    end
  end
end