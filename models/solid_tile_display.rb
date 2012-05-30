class SolidTileDisplay
  attr_reader :title

  def initialize(arguments = {})
    @title = arguments[:title]
    @background_image = arguments[:background_image]
    @background_color = arguments[:background_color]
    @footer_title = arguments[:footer_title]
    @footer_subtitle = arguments[:footer_subtitle]
    @poll = arguments[:poll]
    @live = arguments[:live] == true
  end

  def to_json
    data = {
      ":type" => "application/vnd.playup.display.tile.solid+json",
      "title" => @title,
      "background_color" => @background_color,
      "background_image" => @background_image,
      "footer_subtitle" => @footer_subtitle,
      "footer_title" => @footer_title,
      "live" => @live
    }

    data[":self"] = @poll if @poll
    data
  end
end
