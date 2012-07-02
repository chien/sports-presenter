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
      
      def shorten_name(first_name, last_name)
        first_name[0] + ". " + last_name
      end
      
      def truncate(target, length_limit)
        if target.length > length_limit
          target[0..(length_limit-1)] + "..."
        else
          target
        end
      end
      
    end
  end
end
