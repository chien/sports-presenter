module SportsPresentation
  class SportsApiClient

    def self.fetch(path)
      url = File.join(SportsPresentation.sports_api_host, path)
      headers = {:language => @language, :region => @region}
      body = RestClient.get(url, headers).body

      # Ditch the colon prefixes so we can use recursive open struct.
      # body = body.gsub('":self":', '"_self":').gsub('":type":', '"_type":').gsub('":uid":', '"_uid":')

      SportsApiResponse.new JSON(body)
    end


    def self.fetch(path)
      if path =~ /stage/
        mock_response("stage.json")
      elsif path =~ /competi/
        mock_response("competition.json")
      elsif path =~ /contests/
        mock_response("contest.json")
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
      puts "Mock #{file}"
      SportsApiResponse.new JSON(IO.read(File.join(File.dirname(__FILE__), "../spec/", file)))
    end
  end
end