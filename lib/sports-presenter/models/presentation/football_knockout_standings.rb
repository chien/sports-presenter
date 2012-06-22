module SportsPresentation
  module Presentation
    class FootballKnockoutStandings
      include Presentable
      attr_reader :league_name, :stage_name, :rounds

      def initialize(stage_object)
        @assets = Asset.new(self).extend(PresentationAsset)        
        @group_standings = []
        @rounds = {}

        if stage_object && stage_object.standings
          @league_name = stage_object.competition_name
          @stage_name = stage_object.name
          @rounds = stage_object.standings
        end
      end

      def valid?
        @rounds.length > 0
      end
    end
  end
end