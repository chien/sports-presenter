module SportsPresentation
  module Presentation
    class FootballStandings
      attr_reader :league_name, :stage_name, :group_standings

      def initialize(stage_object)
        
        @group_standings = []

        if stage_object && stage_object.standings
          @league_name = stage_object.competition_name
          @stage_name = stage_object.name

          stage_object.standings.group_by { |standing| standing["group_name"] }.each do |group, standings_data|
            standings = standings_data.sort_by { |standing| standing["position"].to_i }.collect do |standing|
              team_name = standing.at("team.name")
              team_logo = ImageDensities.new(standing.at("team.logos")).calendar_low
              position = standing["position"]

              OpenStruct.new(standing["statistics"].merge(team_name: team_name, team_logo: team_logo, position: position))
            end

            @group_standings << OpenStruct.new(:group => group, :standings => standings)
          end
        end
      end

      def valid?
        @group_standings.length > 0
      end

      def each_group(&block)
        @group_standings.each do |data|
          yield data.group, data.standings
        end
      end

    end
  end
end