module SportsPresentation
  class TileDisplay
    attr_reader :title

    def initialize(arguments = {})

      if arguments[:title].is_a? Symbol
        @title = I18n.t("tiles.#{arguments[:title]}")
      else
        @title = arguments[:title]
      end        
      @poll = arguments[:poll]
    end

    def make_density_lookup(images)
      if images.is_a?(Hash)
        images.collect do |key, href| 
          { "density" => key.to_s, "href" => File.join(SportsPresentation.assets_host, href) }
        end
      else
        images
      end
    end

    def vendor_type
      raise NotImplementedError
    end

    def to_json
      data = {
        ":type" => vendor_type,
        "title" => @title
      }

      data[":self"] = @poll if @poll
      data
    end
  end
end