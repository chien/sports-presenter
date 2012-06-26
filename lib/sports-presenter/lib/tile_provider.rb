module SportsPresentation
  class TileProvider
    def self.fetch_tiles(context_url)
      tiles = TileList.new
      case context_url
        when /\/competitions\/(\d+)$/ then 
          tiles_for_competition($1, tiles)
        when /\/contests\/(\d+)$/ then 
          tiles_for_contest($1, tiles)
        when /welcome$/ then
          tiles_for_home(tiles)
        when /groupings\/([a-z\-]+)/i then
          tiles_for_group($1, $2, tiles)
      end

      tiles
    end

    def self.tiles_for_group(slug, id, tiles)
      # grouping = Api::Grouping.find(slug)

      # grouping.competitions.each do |competition|
      #   tiles.add_native_tile competition.response, Tiles::CompetitionTile.new(competition.name, competition.uid, competition.live_contests)
      # end
      puts slug
      url = case slug
                when 'sprints' then
                  '/groupings/sprints/contests'
                when 'tennis' then
                  '/groupings/tennis/contests'
                else
                  nil
              end
      contests = url.to_s.length != 0 ? Api::Collection.fetch(url)  : [] 
      # contests.each do |contest|
      #   tiles.add_native_tile contest.response, Tiles::ContestTile.new(contest.title, contest.uid, contest.is_live?)
      # end

      # grouping.groupings.each do |grouping|
      #   tiles.add_native_tile grouping.response, Tiles::GroupingTile.new(grouping.name, grouping.uid)
      # end
    end

    def self.tiles_for_competition(id, tiles)
      stages = Api::Stage.find_by_competition_id(id)
      stages.each do |stage|
        if stage && stage.standings 
          stage_url = "/competitions/#{id}/stages/#{stage.id}/standings"
          if stage.is_playup_kind?("application/vnd.playup.sport.stage.home_away")
            tiles.add_link_tile stage_url, Tiles::GroupStandingsTile.new
          elsif stage.is_playup_kind?("application/vnd.playup.sport.stage.knockout") && id == "27" #Euros
            tiles.add_link_tile stage_url, Tiles::KnockoutStandingsTile.new
          end
        end

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

    def self.tiles_for_home(tiles)
      competitions = Api::Competition.all
      competitions.first(4).each do |competition|
        tiles.add_native_tile competition.response, Tiles::CompetitionTile.new(competition.name, competition.uid, competition.live_contests)
      end
    end
  end
end