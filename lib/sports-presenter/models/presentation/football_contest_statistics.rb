module SportsPresentation
  module Presentation
    class FootballEvents
    end
    
    class FootballContestStatistics < FootballEvents

      attr_reader :events

      def initialize(contest)
        super
        @statistics = contest.statistics
      end

      def valid?
        @statistics && @statistics.home_team && @statistics.away_team
      end

      def home_team
        OpenStruct.new(
          :display_name => @statistics.home_team.display_name, 
          :score => @contest.home_team_score,
          :possession_percentage => (@statistics.home_team.possession_percentage.to_f * 100).ceil.to_i,
          :saves => @statistics.home_team.saves,
          :yellow_cards => @statistics.home_team.yellow_cards,
          :red_cards => @statistics.home_team.red_cards,
          :crosses => @statistics.home_team.crosses,
          :fouls => @statistics.home_team.fouls,
          :shot_statistics => @statistics.home_team.shot_statistics
          )
      end

      def away_team
        OpenStruct.new(
          :display_name => @statistics.away_team.display_name, 
          :score => @contest.away_team_score,
          :possession_percentage => (@statistics.away_team.possession_percentage.to_f * 100).ceil.to_i,
          :saves => @statistics.away_team.saves,
          :yellow_cards => @statistics.away_team.yellow_cards,
          :red_cards => @statistics.away_team.red_cards,
          :crosses => @statistics.away_team.crosses,
          :fouls => @statistics.away_team.fouls,
          :shot_statistics => @statistics.away_team.shot_statistics
          )
      end


    end
  end
end