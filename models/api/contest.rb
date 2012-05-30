module Api
  class Contest

    def self.find(id)
      contest = SportsApiClient.fetch("/contests/#{id}")
      
    end

  end
end