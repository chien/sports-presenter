module SportsPresentation
  class Application < Sinatra::Base
    
    get '/contests/:id/events' do
      contest = Api::Contest.find(params[:id])
      @events = Presentation::FootballEvents.new contest
      @additional_stylesheet = "stats"

      haml :match_events_football
    end

  end
end