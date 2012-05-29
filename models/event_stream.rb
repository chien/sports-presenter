class EventStream

  def initialize(events)
    @events = events
  end

  def self.fetch(contest_id)
    new SportsApiClient.fetch("/contests/#{contest_id}/events")
  end

  def events
    @events
  end

end