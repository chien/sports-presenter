module SportsPresentation
  class Application < Sinatra::Base
    
    get '/contests/:id/statistics' do
      contest = Api::Contest.find(params[:id])
      @statistics = Presentation::FootballContestStatistics.new contest
      @additional_stylesheet = "stats"

      haml :match_stats_football
    end

  end
end