module SportsPresentation
  module Api
    class BaseballContestStatistics < Base
      STATS = %w( runs errors hits )

      attr_reader *STATS
      attr_reader :team_id, :display_name, :innings, :players, :pitchers

      def parse_response(stats)
        STATS.each do |stat|
          # This funkyness is to ensure a missing value is set to zero.
          val = stats[stat].to_s
          val = (val =~ /0\./) ? val.to_f : val.to_i

          instance_variable_set("@#{stat}", val)
        end

        @team_id = PlayupTypes.grab_last_id(stats.at("team.:self"))
        @display_name = stats.at("team.display_name")
        @innings = stats.at("innings")

        @players = []
        stats.at("players").each do |player|
          next if player["at_bats"] == 0
          @players << PlayupTypes.wrap(player)
        end
        
        @pitchers = []
        stats.at("pitchers").each do |player|
          @pitchers << PlayupTypes.wrap(player)
        end

        (@players + @pitchers).each do |player_object|
          all_players = (@players + @pitchers)
          all_players.delete(player_object)
          same_name_players = all_players.select{|compared_player|
            compared_player.id != player_object.id && compared_player.last_name == player_object.last_name }
          if same_name_players.size > 0
            same_name_players.each do |player|
              player.display_name = shorten_name(player.first_name, player.last_name)
            end
          else
            player_object.display_name = player_object.last_name
          end
          player_object.display_name = truncate(player_object.display_name, 16)
        end
        
      end
      
    end
  end
end