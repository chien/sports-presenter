module SportsPresentation
  class Application < Sinatra::Base
    
    get '/stages/:id/standings' do
      stage = Api::Stage.find(params[:id])
      @standing = Presentation::FootballStandings.new stage
      @additional_stylesheet = "standings"

      haml :standings_football
    end

    get "/match_stats" do
      haml :match_stats_football
    end

    get "/match_events" do
      haml :match_events_football
    end

  end
end