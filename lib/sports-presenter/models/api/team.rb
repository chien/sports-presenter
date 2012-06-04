module SportsPresentation
  module Api
    class Team < Base

      attr_reader :display_name, :id

      def parse_response(data)
        @display_name = data.at("display_name")
        @id = PlayupTypes.grab_last_id(data)
      end

    end
  end
end
