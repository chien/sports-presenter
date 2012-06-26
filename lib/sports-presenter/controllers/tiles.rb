module SportsPresentation
  class Application < Sinatra::Base
    set :raise_errors, true
    set :show_exceptions, true

    Airbrake.configure do |config|
      config.api_key = '757646976907fb3ae7930559b64cbe58'
    end
    use Airbrake::Rack

    error do
      content_type :json
      status 400 # or whatever

      e = env['sinatra.error']
      {:result => 'error', :message => e.message}.to_json
    end
    
    get "/tiles" do
      content_type :json
      context_url = params[:subject_url].to_s.length != 0 ? params[:subject_url] : params[:section_type]
      tile_data = TileProvider.fetch_tiles(context_url).generate(:locale => locale, :region => region)
      tile_data.to_json
    end
    
  end
end