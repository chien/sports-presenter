module SportsPresentation
  class SportsApiClient

    class << self
      attr_accessor :mode
    end

    def self.fetch(path)
      unless SportsApiClient.mode == :mock
        url = File.join(SportsPresentation.sports_api_host, path)
        headers = {:language => @language, :region => @region}
        body = RestClient.get(url, headers).body

        SportsApiResponse.new JSON(body)
      else
        if path =~ /stage/
          mock_response("stage.json")
        elsif path =~ /competi/
          mock_response("competition.json")
        elsif path =~ /events/
          mock_response("events.json")
        elsif path =~ /contest_details/
          mock_response("contest_details.json")
        elsif path =~ /contests/
          mock_response("contest.json")
        end
      end
    end

    def self.set_language(lang)
      @language = lang
    end

    def self.set_region(region)
      @region = region
    end

    private

    def self.mock_response(file)
      SportsApiResponse.new JSON(IO.read(File.join(File.dirname(__FILE__), "../spec/", file)))
    end
  end
end