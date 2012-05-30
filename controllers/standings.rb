class SportsPresentation < Sinatra::Base
  
  get '/stages/:id/standings' do
    # @standing = FootballStandings.fetch(params[:id])

    json = JSON(IO.read(File.join(File.dirname(__FILE__), "../spec/stage.json")))
    @standing = FootballStandings.new json

    haml :"standings_football"
  end

end