module SportsPresentation
  module Api
    class Collection
      include Enumerable
      def [](index)
        @data[index]
      end 

      def initialize(data)
        @data = []
        data = data["items"] if data.is_a?(Hash)
        data.each do |entry|
          begin
            type = PlayupTypes.resolve(entry.playup_type)
            @data << type.new(entry) if type
          end
        end
      end

      def length
        @data.length
      end

      def reverse
        @data.reverse
      end

      def each(&block)
        @data.each(&block)
      end

      def self.fetch(url)
        new SportsApiClient.fetch(url)
      end

    end
  end
end