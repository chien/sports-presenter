module Api
  class Contest

    attr_reader :all_events

    def initialize(contest)
      @all_events = PlayupTypes.lazyref(contest.at("events.all"))
      @has_events = !!contest.at("events")

      @all_statistics = PlayupTypes.lazyref(contest.at("contest_details"))
      @has_statistics = !!@all_statistics
    end

    def has_events?
      @has_events
    end

    def has_statistics?
      @has_statistics
    end

    def self.find(id)
      contest = SportsApiClient.fetch("/contests/#{id}")
      new(contest)
    end

  end
end