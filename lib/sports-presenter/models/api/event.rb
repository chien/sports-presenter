module SportsPresentation
  module Api
    class Event < Base

      attr_reader :team_id, :event_type, :long_message, :name, :player_name, :at_seconds, :minutes, :seconds, :extra_minutes

      def parse_response(event)
        @team_id = event["team_id"]
        @event_type = event["event_type"]
        @long_message = event["long_message"]
        @name = event["name"]
        @player_name = event["player_name"]
        @at_seconds = (event.at("clock.minutes").to_i * 60) + (event.at("clock.extra_minutes").to_i * 60) + event.at("clock.seconds").to_i
        @minutes = event.at("clock.minutes")
        @extra_minutes = event.at("clock.extra_minutes")
        @seconds = event.at("clock.seconds")

        @minutes = @minutes.to_i if @minutes.to_s.length > 0
        @extra_minutes = @extra_minutes.to_i if @extra_minutes.to_s.length > 0
        @seconds = @seconds.to_i if @seconds.to_s.length > 0
      end

      def total_seconds
        (@minutes.to_i + @extra_minutes.to_i) * 60 + @seconds.to_i
      end

      def minute_code
        "#{@minutes.to_i + @extra_minutes.to_i}\""
      end

    end
  end
end