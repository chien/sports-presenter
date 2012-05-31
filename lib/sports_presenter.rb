require 'rubygems'
require 'bundler'
Bundler.require

module SportsPresentation
  class << self
    attr_accessor :presenter_base_url
    attr_accessor :sports_api_host
  end
end

SportsPresentation.presenter_base_url = "http://localhost:9292"
SportsPresentation.sports_api_host = "http://localhost:3000"

here = File.dirname(__FILE__)

Dir.glob("#{here}/sports-presenter/lib/*.rb").each { |r| require r }
Dir.glob("#{here}/sports-presenter/models/*.rb").each { |r| require r }
Dir.glob("#{here}/sports-presenter/models/tiles/*.rb").each { |r| require r }
Dir.glob("#{here}/sports-presenter/models/api/*.rb").each { |r| require r }
Dir.glob("#{here}/sports-presenter/models/presentation/*.rb").each { |r| require r }
Dir.glob("#{here}/sports-presenter/controllers/*.rb").each { |r| require r }


module SportsPresentation
  class Application < Sinatra::Base

    set :public_folder, Proc.new { File.join(root, "..", "public" ) }

    before do
      SportsApiClient.set_language(params[:lang] || "en")
      SportsApiClient.set_region(params[:region] || 'AU')
    end
  end
end

