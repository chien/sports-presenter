module SportsPresentation
  class TileList
    def initialize
      @tiles = []
    end

    def add_link_tile(href, display)
      raise ArgumentError, "No display" if display.nil?
      raise ArgumentError, "No href" if href.nil?

      @tiles << { :href => href, :display => display, :uid => "sd-tile-#{href.gsub("/", "-")}".gsub("--", "-") }
    end

    def generate(params = {})
      uri = Addressable::URI.parse(SportsPresentation.presenter_base_url)
      uri.query_values = params
      base_path = uri.path

      @tiles.collect do |tile|
        uri.path = File.join(base_path, tile[:href])

        {
          ":type" => "application/vnd.playup.extension+json",
          ":uid" => tile[:uid],
          ":tags" => [],
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
end