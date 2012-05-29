


get '/contests/:id/statistics' do
  @object = FootballContestStatistics.fetch(params[:id])
  haml :football_statistics
end