module SportsPresentation
  module Api
    class FootballRankingStatistics
      attr_reader :played, :won, :drawn, :lost, :goals_for, :goals_against, :difference, :points

      def initialize(stats)
        @played = stats.at("played")
        @won = stats.at("won")
        @drawn = stats.at("drawn")
        @lost = stats.at("lost")
        @goals_for = stats.at("goals_for")
        @goals_against = stats.at("goals_against")
        @difference = stats.at("difference")
        @points = stats.at("points")
      end

    end
  end
end