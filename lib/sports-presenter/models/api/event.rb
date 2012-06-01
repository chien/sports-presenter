module SportsPresentation
  module Api
    class Event

      attr_reader :team_id, :event_type, :long_message, :name, :player_name, :at_seconds, :minutes, :seconds, :extra_minutes

      def initialize(event)
        @team_id = event["team_id"]
        @event_type = event["event_type"]
        @long_message = event["long_message"]
        @name = event["name"]
        @player_name = event["player_name"]
        @at_seconds = (event.at("clock.minutes").to_i * 60) + (event.at("clock.extra_minutes").to_i * 60) + event.at("clock.seconds").to_i
        @minutes = event.at("clock.minutes").to_i
        @extra_minutes = event.at("clock.extra_minutes").to_i
        @seconds = event.at("clock.seconds").to_i
      end

    end
  end
end