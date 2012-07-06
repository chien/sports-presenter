module SportsPresentation
  class TileList
    def initialize
      @tiles = []
    end

    def add_link_tile(href, display)
      raise ArgumentError, "No display" if display.nil?
      raise ArgumentError, "No href" if href.nil?
      uid = href.gsub(SportsPresentation.sports_api_host, "").gsub("/", "-")
      @tiles << { :href => href, :display => display, :uid => "sd-tile-#{uid}" }
    end

    def add_native_tile(object, display)
      raise ArgumentError, "No display" if display.nil?
     
      @tiles << {:object =>object, :display => display}
    end

    def generate(params = {})
      @tiles.collect do |tile|
        type = "text/html"
        if tile[:display].respond_to? :link_type
          type = tile[:display].link_type 
        end

        uri = format_uri(tile[:href], params)
        link_hash = {}
        link_hash[":self"] = uri
        link_hash[":type"] = type
        link_hash[":uid"] = tile[:display].uid if tile[:display].respond_to? :uid

        tile_hash = {}
        tile_hash[":type"] = "application/vnd.playup.extension+json"
        tile_hash[":uid"] = tile[:uid]
        tile_hash[":tags"] = []
        tile_hash["name"] = tile[:display].title
        tile_hash["link"] = link_hash unless tile[:href].nil?
        tile_hash[":display"] = tile[:display].to_json
        tile_hash.merge!(tile[:object]) unless tile[:object].nil?
        tile_hash
      end
    end

    def format_uri(url, params)
      return if url.nil?
      if url.match(/^http/) 
        url
      else
        uri = Addressable::URI.parse(SportsPresentation.presenter_base_url)
        uri.query_values = params
        base_path = uri.path
        uri.path = File.join(base_path, url)
        uri.to_str
      end
    end
  end
end