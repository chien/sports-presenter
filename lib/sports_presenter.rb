require 'rubygems'
# require 'bundler'
# Bundler.require

module SportsPresentation
  class << self
    attr_accessor :presenter_base_url
    attr_accessor :sports_api_host
    attr_accessor :assets_host
  end
end

SportsPresentation.presenter_base_url = "http://localhost:9292"
SportsPresentation.sports_api_host = "http://localhost:3000/"
SportsPresentation.assets_host = "http://sportsdata-staging.s3.amazonaws.com/"

here = File.dirname(__FILE__)

require 'addressable/uri'
require 'sinatra'
require 'json'
require 'haml'
require 'rest-client'
require 'i18n'
require 'benchmark'
require 'airbrake'
require 'json'

Dir.glob("#{here}/sports-presenter/lib/*.rb").each { |r| require r }

require "#{here}/sports-presenter/models/tile_display"
Dir.glob("#{here}/sports-presenter/models/*.rb").each { |r| require r }

Dir.glob("#{here}/sports-presenter/models/tiles/*.rb").each { |r| require r }

require "#{here}/sports-presenter/models/api/base"

Dir.glob("#{here}/sports-presenter/models/api/*.rb").each { |r| require r }
Dir.glob("#{here}/sports-presenter/models/presentation/*.rb").each { |r| require r }
Dir.glob("#{here}/sports-presenter/controllers/*.rb").each { |r| require r }

I18n.load_path += Dir[File.join(here, "sports-presenter", "i18n", "*.yml")]

module SportsPresentation
  class Application < Sinatra::Base

    use LocaleRequest
    use CacheSettings, {
      # Add cache headers to static files.
      /\.(css|png|gif|eot|svg|ttf|woff)/ => {
        :cache_control => "max-age=86400, public",
        :expires => 86400
      }, 

      # Otherwise cache for 5 seconds.
      /.*/ => {
        :cache_control => "max-age=5, public", 
        :expires => 5
      }
    }
    set :public_folder, Proc.new { File.join(root, "..", "public" ) }

    def locale
      request.env["rack.locale"]
    end

    def region
      request.env["rack.region"]
    end

    def country
      request.env["rack.country"]
    end

    helpers do
      def t(*args)
        I18n.t(*args)
      end
    end

    before do
      puts "#{region} #{country} #{locale}"
      SportsApiClient.set_language(I18n.locale)
      SportsApiClient.set_region(region)
      # SportsApiClient.set_country(country)
      
      SportsPresentation::SportsApiClient.mode = nil #(params[:real] == "true" ? nil : :mock)
    end
  end
end

