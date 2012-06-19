module SportsPresentation
  class Application < Sinatra::Base
    
    get '/competitions/:competition_id/stages/:id/standings' do
      stage = Api::Stage.find(params[:competition_id], params[:id])
      @standing = Presentation::FootballStandings.new stage
      @additional_stylesheet = "standings"
      @title = t("tiles.competition_standings")

      if @standing.valid?
        haml :standings_football
      else
        haml :no_data
      end
    end

  end
end