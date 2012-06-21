module SportsPresentation
  module Presentation
    
    class BaseballContestStatistics

      attr_reader :events

      def initialize(contest)
        super
        @statistics = contest.statistics
      end

      def valid?
        @statistics && @statistics.home_team && @statistics.away_team
      end
      
      def home_team
        build_struct(:home_team)
      end

      def away_team
        build_struct(:away_team)
      end
      
      def total_innings
        @statistics.away_team.innings.size > 9 ? @statistics.away_team.innings.size : 9
      end
      
      private 
      
      # team_type should be :home_team or :away_team
      def build_struct(team_type)
        return unless team_stat = @statistics.send(team_type)
        players = team_stat.players.find_all{|player| player["at_bats"] != 0 }
        total = {}
        [:runs, :homeruns, :singles, :doubles, :triples, :walks, :rbi, :stolen_bases, :at_bats, :strike_outs].each do |player_stat|
          total[player_stat.to_s] = players.map{|p| p[player_stat.to_s] }.inject(0, :+)
        end
        OpenStruct.new(
          :display_name => team_stat.display_name,
          :runs => team_stat.runs,
          :hits => team_stat.hits,
          :errors => team_stat.errors,
          :innings => team_stat.innings,
          :players => players,
          :total => total
        )        
      end

    end
  end
end