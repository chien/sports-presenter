module SportsPresentation
  class ImageDensities

    def initialize(data)
      @data = data
    end

    def calendar_low
      @data.at("calendar").select { |logo| logo["density"] == "low" }.first["href"]
    rescue
      nil
    end

    def calendar_medium
      @data.at("calendar").select { |logo| logo["density"] == "medium" }.first["href"]
    rescue
      nil
    end

  end
end