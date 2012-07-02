module SportsPresentation
  class SolidTileDisplay < TileDisplay

    def initialize(arguments = {})
      super

      @background_color = arguments[:background_color]
      @footer_title = arguments[:footer_title]
      @footer_subtitle = arguments[:footer_subtitle]
      @live = arguments[:live] == true

      @background_image = make_density_lookup(arguments[:background_image]) unless arguments[:background_image].nil?
      @background_color = "0x#{$1}" if @background_color =~ /\#(.*)/
    end

    def vendor_type
      "application/vnd.playup.display.tile.solid+json"
    end

    def to_json
      data = super

      data["background_color"] = @background_color if @background_color
      data["background_image"] = @background_image if @background_image
      data["footer_subtitle"] = @footer_subtitle if @footer_subtitle
      data["footer_title"] = @footer_title if @footer_title
      data["live"] = true if @live

      data
    end
  end
end