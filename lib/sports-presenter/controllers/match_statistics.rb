module SportsPresentation
  class Application < Sinatra::Base
    
    get '/contests/:id/statistics' do
      contest = Api::Contest.find(params[:id])
      @statistics = Presentation::FootballContestStatistics.new contest
      @additional_stylesheet = "stats"
      @title = t("tiles.contest_statistics")

      if @statistics.valid?
        haml :match_stats_football
      else
        haml :no_data
      end
    end

  end
end