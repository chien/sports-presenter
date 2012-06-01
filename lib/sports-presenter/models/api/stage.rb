module SportsPresentation
  module Api
    class Stage

      attr_reader :standings, :name, :competition_name

      def initialize(stage)
        @standings = PlayupTypes.wrap(stage.at("standings"))
        @name = stage.at("name")
        @competition_name = stage.at("competition_name")
        @stage_id = PlayupTypes.grab_last_id(stage)
      end

      def id
        @stage_id
      end

      def self.find(id)
        stage = SportsApiClient.fetch("/stages/#{id}")
        new(stage)
      end

    end
  end
end