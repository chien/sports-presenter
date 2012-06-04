module SportsPresentation
  class SolidTileDisplay
    attr_reader :title

    def initialize(arguments = {})
      @title = arguments[:title]
      @background_color = arguments[:background_color]
      @footer_title = arguments[:footer_title]
      @footer_subtitle = arguments[:footer_subtitle]
      @poll = arguments[:poll]
      @live = arguments[:live] == true

      if images = arguments[:background_image]
        if images.is_a?(Hash)
          @background_image = images.collect do |key, href| 
            { "density" => key.to_s, "href" => File.join(SportsPresentation.assets_host, href) }
          end
        else
          @background_image = images
        end
      end

    end

    def to_json
      data = {
        ":type" => "application/vnd.playup.display.tile.solid+json",
        "title" => @title,
        "background_color" => @background_color,
        "footer_subtitle" => @footer_subtitle,
        "footer_title" => @footer_title,
        "live" => @live
      }

      data["background_image"] = @background_image if @background_image

      data[":self"] = @poll if @poll
      data
    end
  end
end