module SportsPresentation
  module Tiles
    class CompetitionTile < PhotoTileDisplay

      def initialize(competition_hash)
        title = competition_hash["name"]
        uid = competition_hash[":uid"]
        is_live = competition_hash["live_contests"] > 0
        super live: is_live, translated_title: title, image: images(uid)
      end

      def images uid
        has_logo = begin
          RestClient.get(SportsPresentation.assets_host+"tiles/statistics/football/#{uid}_low_148_88.png").code == 200
        rescue
          false
        end

        if has_logo
          {
            low: "/tiles/statistics/football/#{uid}_low_148_88.png",
            medium: "/tiles/statistics/football/#{uid}_medium_222_132.png",
            high: "/tiles/statistics/football/#{uid}_high_296_176.png"
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