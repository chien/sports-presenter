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
SportsPresentation.sports_api_host = "http://localhost:3000"
SportsPresentation.assets_host = "http://sportsdata-staging.s3.amazonaws.com/"

here = File.dirname(__FILE__)

require 'addressable/uri'
require 'sinatra'
require 'json'
require 'haml'
require 'rest-client'
require 'i18n'

Dir.glob("#{here}/sports-presenter/lib/*.rb").each { |r| require r }
Dir.glob("#{here}/sports-presenter/models/*.rb").each { |r| require r }
Dir.glob("#{here}/sports-presenter/models/tiles/*.rb").each { |r| require r }

require "#{here}/sports-presenter/models/api/base"

Dir.glob("#{here}/sports-presenter/models/api/*.rb").each { |r| require r }
Dir.glob("#{here}/sports-presenter/models/presentation/*.rb").each { |r| require r }
Dir.glob("#{here}/sports-presenter/controllers/*.rb").each { |r| require r }

I18n.backend.load_translations *Dir[File.join(here, "sports-presenter", "i18n", "*.yml")]

module SportsPresentation
  class Application < Sinatra::Base

    set :public_folder, Proc.new { File.join(root, "..", "public" ) }

    def locale_from_query
      params[:lang] || params[:locale] || "en"
    end

    helpers do
      def t(key, *options)
        args = options.pop || Hash.new
        args[:locale] = locale_from_query

        I18n.t(key, *options, args)
      end
    end

    before do
      SportsApiClient.set_language(locale_from_query)
      SportsApiClient.set_region(params[:region] || 'EU')
      
      SportsPresentation::SportsApiClient.mode = nil #(params[:real] == "true" ? nil : :mock)
    end
  end
end

