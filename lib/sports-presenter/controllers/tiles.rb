module SportsPresentation
  class Application < Sinatra::Base
    
    get "/tiles" do
      content_type :json
      tile_data = TileProvider.fetch_tiles(params[:subject_url]).generate(:lang => params[:locale], :region => params[:geo_region])
      tile_data.to_json
    end
    
  end
end