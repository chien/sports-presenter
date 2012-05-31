require 'rubygems'
require 'bundler'
Bundler.require

Dir.glob("lib/*.rb").each { |r| require "./#{r}" }
Dir.glob("models/*.rb").each { |r| require "./#{r}" }
Dir.glob("models/tiles/*.rb").each { |r| require "./#{r}" }
Dir.glob("models/api/*.rb").each { |r| require "./#{r}" }
Dir.glob("models/presentation/*.rb").each { |r| require "./#{r}" }
Dir.glob("controllers/*.rb").each { |r| require "./#{r}" }


class SportsPresentation < Sinatra::Base
  set :public_folder, Proc.new { File.join(root, "..", "public" ) }

  before do
    SportsApiClient.set_language(params[:lang] || "en")
    SportsApiClient.set_region(params[:region] || 'AU')
  end
end