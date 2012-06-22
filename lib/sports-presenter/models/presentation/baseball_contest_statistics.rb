module SportsPresentation
  module Presentation
    
    class BaseballContestStatistics
      include Presentable

      def initialize(contest)
        super
        @assets = Asset.new(self).extend(JqueryMobileAsset).extend(PresentationAsset)
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
        total_hash = {}
        [:runs, :homeruns, :singles, :doubles, :triples, :walks, :rbi, :stolen_bases, :at_bats, :strike_outs].each do |player_stat|
          total_hash[player_stat.to_s] = team_stat.players.map{|p| p.send(player_stat) }.inject(0, :+)
        end
        total_hash["hits"] = total_hash["singles"] + total_hash["doubles"] + total_hash["triples"] + total_hash["homeruns"]
        total = OpenStruct.new(total_hash)
        OpenStruct.new(
          :display_name => team_stat.display_name,
          :runs => team_stat.runs,
          :hits => team_stat.hits,
          :errors => team_stat.errors,
          :innings => team_stat.innings,
          :players => team_stat.players,
          :total => total
        )        
      end

    end
  end
end