module SportsPresentation
  module Presentation
    class FootballEvents
      include Presentable
      
      attr_reader :events

      def initialize(contest)
        @contest = contest
        @assets = Asset.new(self).extend(PresentationAsset)
        @events = contest.events || []
      end

      def valid?
        @events.length > 0
      end

      def home_team
        OpenStruct.new(:name => @contest.home_team.display_name, :score => @contest.home_team_score)
      end

      def away_team
        OpenStruct.new(:name => @contest.away_team.display_name, :score => @contest.away_team_score)
      end

      def competition_name
        @contest.competition_name
      end

      def round_name
        @contest.round_display_name
      end

      # Breaks goals into groups of sequential goals per side.
      def goals_rundown
        data = @events.sort_by { |event| -event.at_seconds }.select { |event| event.event_type =~ /goal/ }

        return [] if data.length == 0

        goal_blocks = []
        current_block = goal_block(data.first.team_id)

        data.each do |event|
          unless current_block.team_id == event.team_id
            goal_blocks << current_block
            current_block = goal_block(event.team_id)
          end

          current_block.list << make_goal_display(event)
        end

        goal_blocks << current_block unless current_block.list.length == 0

        goal_blocks
      end

      def event_list
        @events.reverse.collect do |event|
          wrap_event(event)
        end
      end

      private

      def wrap_event(event)
        minutes = event.minutes.to_i + event.extra_minutes.to_i
        seconds = "%02d" % event.seconds.to_i

        time_code = if minutes > 0
          [minutes, seconds].join(":")
        else
          nil
        end

        class_name = case event.team_id
        when @contest.home_team.id.to_s then "home-team"
        when @contest.away_team.id.to_s then "away-team"
        else
          "game"
        end

        OpenStruct.new(:time_code => time_code, :name => event.name, :message => event.long_message, :class_name => class_name)
      end

      def make_goal_display(event)
        OpenStruct.new(:time => event.minute_code, :player_name => event.player_name)
      end

      def goal_block(team_id)
        side = @contest.home_team.id.to_s == team_id.to_s ? :home : :away
        OpenStruct.new(:team_id => team_id, :side => side, :list => [])
      end

    end
  end
end