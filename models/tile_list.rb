class TileList
  PRESENTER_BASE_URL = "http://something.com"
  def initialize
    @tiles = []
  end

  def add_link_tile(href, display)
    raise ArgumentError, "No display" if display.nil?
    raise ArgumentError, "No href" if href.nil?

    @tiles << { :href => href, :display => display, :uid => "sd-tile-#{href.gsub("/", "-")}".gsub("--", "-") }
  end

  def generate(params = {})
    uri = Addressable::URI.parse(PRESENTER_BASE_URL)
    uri.query_values = params

    @tiles.collect do |tile|
      uri.path = tile[:href]

      {
        ":type" => "application/vnd.playup.extension+json",
        ":uid" => tile[:uid],
        "name" => tile[:display].title,
        "link" => {
          ":self" => uri.to_str,
          ":type" => "text/html"
        },
        ":display" => tile[:display].to_json
      }
    end
  end
end