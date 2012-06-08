module SportsPresentation
  module Api
    class Base

      attr_reader :response

      def initialize(response)
        @response = response
        parse_response(response)
      end

      def parse_response(response)
        raise NotImplementedError
      end

      def is_playup_kind?(vars)
        puts @response.ancestor_types
        @response.is_playup_kind?(vars)
      end

    end
  end
end
