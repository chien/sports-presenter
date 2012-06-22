module SportsPresentation
  class Application < Sinatra::Base
    
    get '/contests/:id/events' do
      contest = Api::Contest.find(params[:id])
      @events = Presentation::FootballEvents.new contest
      @stylesheets = @events.stylesheets
      @title = t("tiles.contest_events")

      if @events.valid?
        haml :match_events_football
      else
        haml :no_data
      end
    end

  end
end