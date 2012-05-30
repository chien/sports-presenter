class SportsPresentation < Sinatra::Base
  
  get "/tiles" do
    content_type :json
    tile_data = TileProvider.fetch_tiles(params[:context_url]).generate(:lang => "en", :region => "OC")
    tile_data.to_json
  end
  
end