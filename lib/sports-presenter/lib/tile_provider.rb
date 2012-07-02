module SportsPresentation
  class TileProvider
    def self.fetch_tiles(subject, uid, section)
      tiles = TileList.new
      case subject
        when /\/competitions\/(\d+)$/ then 
          tiles_for_competition($1, tiles)
        when /\/contests\/(\d+)$/ then 
          tiles_for_contest($1, tiles)
        end
        case section
        when "grouping" then
          uid_array = uid.split("-")
          tiles_for_group(uid_array[1], uid_array[2], tiles)
        when "welcome" then
          tiles_for_home(tiles)
        end

      tiles
    end

    def self.tiles_for_group(slug, id, tiles)
      # grouping = Api::Grouping.find(slug)
      puts slug
      contest_url = case slug
                when 'sprints' then
                  '/groupings/sprints/contests'
                when 'tennis' then
                  '/groupings/tennis/contests'
                else
                  nil
              end
      competition_range = case slug
                when 'sprints' then
                  5..8
                when 'tennis' then
                  20..22  
                else
                nil
              end
      puts contest_url
      contests = contest_url.to_s.length != 0 ? Api::Collection.fetch(contest_url)  : [] 

      grouping = Api::Grouping.find(slug)
      competitions = Api::Collection.fetch('competitions')
      
      unless competition_range.nil?
        competitions[competition_range].each do |competition|
          tiles.add_native_tile competition.response, Tiles::CompetitionTile.new(competition.name, competition.uid, competition.live_contests)
        end
      end

      contests.each do |contest|
        tiles.add_link_tile contest.url, Tiles::ContestTile.new(contest.title, contest.uid, contest.is_live?, contest.link_type)
      end

      grouping.groupings.each do |ref|
        grouping = ref.fetch
        tiles.add_link_tile grouping.url, Tiles::GroupingTile.new(grouping.name, grouping.uid, grouping.link_type)
      end
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