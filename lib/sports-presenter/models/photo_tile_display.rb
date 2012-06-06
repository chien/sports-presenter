module SportsPresentation
  class PhotoTileDisplay < TileDisplay

    def initialize(arguments = {})
      super

      @footer_title = arguments[:footer_title]
      @footer_subtitle = arguments[:footer_subtitle]
      @live = arguments[:live] == true

      @image = make_density_lookup(arguments[:image])
    end

    def vendor_type
      "application/vnd.playup.display.tile.photo+json"
    end

    def to_json
      data = super

      data["image"] = @image
      data["footer_subtitle"] = @footer_subtitle if @footer_subtitle
      data["footer_title"] = @footer_title if @footer_title
      data["live"] = @live

      data
    end
  end
end