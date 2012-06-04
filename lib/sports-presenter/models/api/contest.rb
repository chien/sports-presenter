module SportsPresentation
  module Api
    class Contest

      attr_reader :competition_name, :round_name, :home_team, :away_team
      attr_reader :home_team_score, :away_team_score

      def initialize(contest)
        @all_events = PlayupTypes.lazyref(contest.at("events.all"))
        @has_events = !!contest.at("events")

        @all_statistics = PlayupTypes.lazyref(contest.at("contest_details"))
        @has_statistics = !!@all_statistics

        @competition_name = contest.at("competition_name")

        @scores = contest.at("scores")

        @home_team = PlayupTypes.wrap @scores.first.at("team")
        @away_team = PlayupTypes.wrap @scores.last.at("team")

        @home_team_score = @scores.first.at("summary")
        @away_team_score = @scores.last.at("summary")

        @round_name = contest.at("round_name")
      end

      def has_events?
        @has_events
      end

      def has_statistics?
        @has_statistics
      end

      def events
        @all_events = @all_events.fetch if @all_events.is_a?(Api::Ref)
      end

      def statistics
        @all_statistics = @all_statistics.fetch if @all_statistics.is_a?(Api::Ref)
      end

      def self.find(id)
        contest = SportsApiClient.fetch("/contests/#{id}")
        new(contest)
      end

    end
  end
end