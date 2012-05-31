module SportsPresentation
  module Api
    class Collection
      include Enumerable

      def initialize(data)
        @data = []
        data.each do |entry|
          begin
            type = PlayupTypes.resolve(entry.playup_type)
            @data << type.new(entry) if type
          end
        end
      end

      def each(&block)
        @data.each(&block)
      end

    end
  end
end