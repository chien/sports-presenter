module SportsPresentation
  module Tiles
    class ContestTile < SolidTileDisplay
      attr_reader :uid, :name, :link_type
      def initialize(name, uid, is_live, link_type)
        @uid = uid
        @name = name
        @link_type = link_type
        super live: is_live, title: name, background_color: "#F6F6F3"
      end

    end
  end
end