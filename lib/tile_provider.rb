class TileProvider
  def self.fetch_tiles(context_url)
    tiles = TileList.new

    case context_url
    when /\/competitions\/(\d+)$/ then tiles += tiles_for_competition($1, tiles)
    when /\/contest\/(\d+)$/ then tiles += tiles_for_contest($1, tiles)
    end

    tiles.add_link_tile "/stages/4/standings", Tiles::StandingsTile.new
    tiles.add_link_tile "/stages/4", Tiles::StandingsTile.new

    tiles
  end

  def self.tiles_for_competition(id, tiles)
    stage = Competition.find(id).current_stage
    if stage.standings
      tiles.add_link_tile "/stages/#{stage.id}/standings", Tiles::StandingsTile.new
    end
  end

  def self.tiles_for_contest(id, tiles)
    contest = Contest.find(id)
    if contest.events
      tiles.add_link_tile "/contests/#{id}/events", Tiles::EventsTile.new
    end
  end
end