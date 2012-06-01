module SportsPresentation
  class PlayupTypes

    def self.grab_last_id(content)
      content[":self"] =~ /\/(\d+)$/ ? $1 : nil
    end

    def self.resolve(mime_type)
      return nil if mime_type.nil?

      actual = mime_type.split("/", 2).last.split("+", 2).first

      case actual
      when "vnd.playup.sport.contest.contest" then Api::Contest
      when "vnd.playup.sport.contest_detail.football" then Api::ContestDetails
      when "vnd.playup.sport.competition" then Api::Competition
      when "vnd.playup.sport.competitions" then Api::Collection
      when "vnd.playup.sport.competition.stage.home_away" then Api::Stage
      when "vnd.playup.sport.competition.stage.knockout" then Api::Stage
      when "vnd.playup.sport.ranking.statistics.football" then Api::FootballRankingStatistics
      when "vnd.playup.collection" then Api::Collection
      when /vnd\.playup\.sport\.event\.events\.football_(.*)/ then Api::Event
      end

    end

    def self.lazyref(response)
      Api::Ref.wrap(response)
    end

    def self.wrap(response)
      if response.is_a?(Array)
        response.collect { |r| wrap(r) || r }
      elsif type = resolve(response.playup_type)
        puts "Wrapping #{type}"
        type.new(response) if type
      end
    end
  end
end