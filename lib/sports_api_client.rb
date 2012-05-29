class SportsApiClient
  SPORTS_HOST = "http://localhost:3000"

  def self.fetch(url)
    RecursiveOpenStruct.new JSON(RestClient.get(File.join(SPORTS_HOST, url)).body)
  end

  def self.set_language(lang)
    @language = lang
  end

  def self.set_region(reg)
    
  end
end