module SportsPresentation
  class TileProvider
    def self.fetch_tiles(context_url)
      tiles = TileList.new

      case context_url
      when /\/competitions\/(\d+)$/ then tiles_for_competition($1, tiles)
      when /\/contests\/(\d+)$/ then tiles_for_contest($1, tiles)
      end

      tiles
    end

    def self.tiles_for_competition(id, tiles)
      stage = Api::Competition.find(id).current_stage
      if stage.standings && contest.is_playup_kind?("vnd.playup.sport.sport.football")
        tiles.add_link_tile "/stages/#{stage.id}/standings", Tiles::StandingsTile.new
      end
    end

    def self.tiles_for_contest(id, tiles)
      contest = Api::Contest.find(id)
      if contest.has_events? && contest.is_playup_kind?("vnd.playup.sport.sport.football")
        tiles.add_link_tile "/contests/#{id}/events", Tiles::EventsTile.new
      end

      if contest.has_statistics? && contest.is_playup_kind?("vnd.playup.sport.sport.football")
        tiles.add_link_tile "/contests/#{id}/statistics", Tiles::ContestStatisticsTile.new
      end
    end
  end
end