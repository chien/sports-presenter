module SportsPresentation
  class Application < Sinatra::Base
    
    get '/contests/:id/statistics' do
      contest = Api::Contest.find(params[:id])
      klass = SportsPresentation::Presentation.const_get(contest.sport + "ContestStatistics")
      @statistics = klass.new contest
      @additional_stylesheet = "stats"
      @additional_javascript = "JQUI"

      @title = t("tiles.contest_statistics")

      if @statistics.valid?
        haml "match_stats_#{contest.sport.downcase}".to_sym
      else
        haml :no_data
      end
    end

  end
end