class SportsApiClient
  SPORTS_HOST = "http://localhost:3000"

  def self.fetch(path)
    url = File.join(SPORTS_HOST, path)
    headers = {:language => @language, :region => @region}
    RecursiveOpenStruct.new JSON(RestClient.get(url, headers).body)
  end

  def self.set_language(lang)
    @language = lang
  end

  def self.set_region(region)
    @region = region
  end
end