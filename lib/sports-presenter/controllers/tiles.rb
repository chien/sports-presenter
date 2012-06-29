module SportsPresentation
  class Application < Sinatra::Base
    set :raise_errors, true
    set :show_exceptions, true

    error do
      content_type :json
      status 400 # or whatever

      e = env['sinatra.error']
      {:result => 'error', :message => e.message}.to_json
    end

    get "/tiles" do
      content_type :json
      subject = params[:subject_url].to_s.length != 0 ? params[:subject_url] : params[:section_type]
      section = params[:section_type]      
      uid = params[:subject_uid].to_s.length != 0 ? params[:subject_uid] : ''
      tile_data = TileProvider.fetch_tiles(subject, uid, section).generate(:locale => locale, :region => region)
      tile_data.to_json
    end
    
  end
end