module SportsPresentation
  module Presentation
    class FootballContestStatistics

      attr_reader :events

      def initialize(contest)
        @contest = contest
        @statistics = contest.statistics
        @events = contest.events
      end

      def home_team
        @statistics.home_team
      end

      def away_team
        @statistics.away_team
      end

      def competition_name
        @contest.competition_name
      end

      def round_name
        @contest.round_name
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

      private

      def make_goal_display(event)
        OpenStruct.new(:time => event.minute_code, :player_name => event.player_name)
      end

      def goal_block(team_id)
        side = home_team.team_id == team_id ? :home : :away
        OpenStruct.new(:team_id => team_id, :side => side, :list => [])
      end

    end
  end
end