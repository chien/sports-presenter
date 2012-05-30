class SportsApiClient
  SPORTS_HOST = "http://localhost:3000"

  def self.fetch(path)
    url = File.join(SPORTS_HOST, path)
    headers = {:language => @language, :region => @region}
    body = RestClient.get(url, headers).body

    # Ditch the colon prefixes so we can use recursive open struct.
    # body = body.gsub('":self":', '"_self":').gsub('":type":', '"_type":').gsub('":uid":', '"_uid":')

    SportsApiResponse.new JSON(body)
  end

  def self.set_language(lang)
    @language = lang
  end

  def self.set_region(region)
    @region = region
  end
end