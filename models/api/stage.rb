module Api
  class Stage

    attr_reader :standings, :name, :competition_name

    def initialize(stage)
      @standings = PlayupTypes.wrap(stage.at("standings"))
      @name = stage.at("name")
      @competition_name = stage.at("competition_name")
    end

    def self.find(id)
      stage = SportsApiClient.fetch("/stages/#{id}")
      new(stage)
    end

  end
end