module SportsPresentation
  module Api
    class Ref < Base

      def parse_response(hash)
        @href = hash.at(":self")
        @type = hash.at(":type")
      end

      def self.wrap(hash)
        if hash && hash[":self"]
          new(hash)
        else
          nil
        end
      end

      def fetch
        puts "Fetching #{@href}"
        result = SportsApiClient.fetch(@href)
        PlayupTypes.wrap(result)
      end

    end
  end
end