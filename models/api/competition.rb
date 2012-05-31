module Api
  class Competition

    def initialize(competition)
      @current_stage = PlayupTypes.wrap competition.at("current_stage")
    end

    def self.find(id)
      competition = SportsApiClient.fetch("/competitions/#{id}")
      new(competition)
    end

    def current_stage
      if @current_stage.respond_to?(:fetch) 
        @current_stage = @current_stage.fetch
      else
        @current_stage
      end
    end

  end
end