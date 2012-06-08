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

    def add_native_tile(object, display)
      raise ArgumentError, "No display" if display.nil?
     
      @tiles << {:object =>object, :display => display}
    end

    def generate(params = {})
      uri = Addressable::URI.parse(SportsPresentation.presenter_base_url)
      uri.query_values = params
      base_path = uri.path
      @tiles.collect do |tile|
        uri.path = File.join(base_path, tile[:href]) unless tile[:href].nil?
        tile_hash = {}
        tile_hash[":type"] = "application/vnd.playup.extension+json"
        tile_hash[":uid"] = tile[:uid]
        tile_hash[":tags"] = []
        tile_hash["name"] = tile[:display].title
        tile_hash["link"] = {
                              ":self" => uri.to_str,
                              ":type" => "text/html"
                            } unless tile[:href].nil?
        tile_hash[":display"] = tile[:display].to_json
        tile_hash.merge!(tile[:object]) unless tile[:object].nil?
        tile_hash
      end
    end
  end
end