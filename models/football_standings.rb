class FootballStandings

  attr_reader :league_name, :stage_name

  def initialize(data)
    @league_name = data["name"]
    @stage_name = data["stage_name"]
    
    @group_standings = []

    data["standings"].group_by { |standing| standing["group_name"] }.each do |group, standings_data|
      standings = standings_data.sort_by { |standing| standing["position"].to_i }.collect do |standing|
        team_name = standing["team"]["name"]
        team_logo = standing["team"]["logos"]["calendar"].select { |logo| logo["density"] == "low" }.first["href"]
        position = standing["position"]

        OpenStruct.new(standing["statistics"].merge(team_name: team_name, team_logo: team_logo, position: position))
      end

      @group_standings << OpenStruct.new(:group => group, :standings => standings)
    end
  end

  def self.fetch(league_id)
    new SportsApiClient.fetch("/leagues/#{league_id}/current_standings")
  end

  def each_group(&block)
    @group_standings.each do |data|
      yield data.group, data.standings
    end
  end

end