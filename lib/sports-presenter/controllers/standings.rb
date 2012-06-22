module SportsPresentation
  class Application < Sinatra::Base
    
    get '/competitions/:competition_id/stages/:id/standings' do
      stage = Api::Stage.find(params[:competition_id], params[:id])

      if stage.is_playup_kind?("application/vnd.playup.sport.stage.home_away")
        @standing = Presentation::FootballStandings.new stage
        view = :standings_football
        @title = t("tiles.group_standings")
        @additional_stylesheet = "standings"
      elsif stage.is_playup_kind?("application/vnd.playup.sport.stage.knockout")
        @standing = Presentation::FootballKnockoutStandings.new stage
        view = :knockout_standings_football
        @title = t("tiles.knockout_standings")
        @additional_stylesheet = "elimination"
      end
      
      if @standing.valid?
        haml view
      else
        haml :no_data
      end
    end

  end
end