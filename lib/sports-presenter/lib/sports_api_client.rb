module SportsPresentation
  class SportsApiClient

    class << self
      attr_accessor :mode
    end

    def self.fetch(path)
      unless SportsApiClient.mode == :mock
        url = if path =~ /http\:/
          path
        else
          File.join(SportsPresentation.sports_api_host, path)
        end

        puts url.to_s
        puts "Locale: #{@language} Geoip: #{@region}"
        headers = { "Accept-Language" => @language, "X-PlayUp-Geoip-Country-Code" => @region }
        body = nil
        time_taken = Benchmark.measure do
          body = RestClient.get(url, headers).body
        end

        puts "Request time #{(time_taken.real * 1000).ceil} ms"

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