module SportsPresentation
  class Application < Sinatra::Base
    
    get "/tiles" do
      content_type :json
      context_url = params[:subject_url].to_s.length != 0 ? params[:subject_url] : params[:section_type]
      tile_data = TileProvider.fetch_tiles(context_url).generate(:locale => locale, :region => region)
      tile_data.to_json
    end
    
  end
end