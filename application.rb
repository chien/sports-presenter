Dir.glob("lib/*.rb").each { |r| require "./#{r}" }
Dir.glob("models/*.rb").each { |r| require "./#{r}" }
Dir.glob("models/tiles/*.rb").each { |r| require "./#{r}" }
Dir.glob("controllers/*.rb").each { |r| require "./#{r}" }


class SportsPresentation < Sinatra::Base
  before do
    SportsApiClient.set_language(params[:lang] || "en")
    SportsApiClient.set_region(params[:region] || 'AU')
  end
end