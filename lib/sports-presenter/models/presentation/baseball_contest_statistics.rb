module SportsPresentation
  module Presentation
    
    class BaseballContestStatistics
      include Presentable

      def initialize(contest)
        super
        @assets = Asset.new(self).extend(JqueryMobileAsset).extend(SwipeAsset).extend(PresentationAsset)
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
        
        total_pitcher_hash = {}
        [:hits, :runs, :earned_runs, :walks, :strike_outs, :homeruns].each do |player_stat|
          total_pitcher_hash[player_stat.to_s] = team_stat.pitchers.map{|p| p.send(player_stat) }.inject(0, :+)
        end
        total_pitcher_hash[:innings] = team_stat.pitchers.map{|p| p.send(:innings).to_f }.inject(0, :+)
        total_pitcher_hash[:innings] = (total_pitcher_hash[:innings] - total_pitcher_hash[:innings].round > 0.2) ? total_pitcher_hash[:innings].ceil : total_pitcher_hash[:innings]
        total_pitcher = OpenStruct.new(total_pitcher_hash)
        
        OpenStruct.new(
          :display_name => team_stat.display_name,
          :runs => team_stat.runs,
          :hits => team_stat.hits,
          :errors => team_stat.errors,
          :innings => team_stat.innings,
          :players => team_stat.players,
          :pitchers => team_stat.pitchers,
          :total => total,
          :total_pitcher => total_pitcher
        )        
      end

    end
  end
end