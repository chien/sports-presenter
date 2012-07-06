module SportsPresentation
  module Api
    class KnockoutRound
      include Enumerable
      attr_reader :contests, :name

      def initialize(data)
        @data = data
        @contests = []
        @name = data["name"]
        data["items"].each do |entry|
          begin
            type = PlayupTypes.resolve(entry.playup_type)
            @contests << type.new(entry) if type
          end
        end
      end
    end
  end
end