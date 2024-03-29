module SportsPresentation
  module Api
    class Stage < Base

      attr_reader :standings, :name, :competition_name

      def parse_response(stage)
        @standings = PlayupTypes.wrap(stage.at("standings"))
        @name = stage.at("name")
        @competition_name = stage.at("competition_name")
        @stage_id = PlayupTypes.grab_last_id(stage)
      end

      def id
        @stage_id
      end

      def self.find_by_competition_id(competition_id)
        stages = SportsApiClient.fetch("/competitions/#{competition_id}/stages")
        Api::Collection.new(stages)
      end

      def self.find(competition_id, id)
        stage = SportsApiClient.fetch("/competitions/#{competition_id}/stages/#{id}")
        new(stage)
      end

    end
  end
end