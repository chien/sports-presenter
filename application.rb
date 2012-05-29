class SportsPresentation < Sinatra::Base
  before do
    SportsApiClient.set_language(params[:lang] || "en")
    SportsApiClient.set_region(params[:region] || 'AU')
  end
end