class SportsPresentation < Sinatra::Base
  
  get '/' do  
    json = %{{
    ":self": "http://localhost:3000/competitions/71/current_standings", 
    ":type": "application/vnd.playup.sport.competition.standings+json", 
    ":uid": "competition-71-stages-5-standings", 
    "ancestors": [
        {
          ":self": "http://localhost:3000/competitions/71", 
          ":type": "application/vnd.playup.sport.competition+json", 
          ":uid": "competition-71"
        },
        {
            ":self": "http://localhost:3000/sports/9", 
            ":type": "application/vnd.playup.sport.sport.football+json", 
            ":uid": "sport-9"
        }, 
        {
            ":self": "http://localhost:3000/sports", 
            ":type": "application/vnd.playup.sport.sports+json", 
            ":uid": "sports"
        }
    ],
    "name": "Euro 2012", 
    "region": "EU", 
    "short_name": "NFL", 
    "stage_name":"Final Torment-Group Stage",
    "teams": {
        ":self": "http://localhost:3000/competitions/71/teams", 
        ":type": "application/vnd.playup.collection+json", 
        ":uid": "competition-71-teams"
    },
      "standings":[
        {
          "position":1,
          "group_name": "Group A",
            "team":{  
              ":self": "http://localhost:3000/teams/525",
                      ":type": "application/vnd.playup.sport.team+json",
                      ":uid": "team-525",
                      "display_name": "Cardinals",
                      "name": "Arizona",
                      "short_name": "ARI",
                      "logos": {
                        "header": [
                        {
                        "density": "low",
                        "href": "http://playuplogos-dev.s3.amazonaws.com/team-logos/american_football/american_football_cardinals_ari_1333419218_70x46.png"
                        },
                        {
                        "density": "medium",
                        "href": "http://playuplogos-dev.s3.amazonaws.com/team-logos/american_football/american_football_cardinals_ari_1333419218_105x69.png"
                        },
                        {
                        "density": "high",
                        "href": "http://playuplogos-dev.s3.amazonaws.com/team-logos/american_football/american_football_cardinals_ari_1333419218_140x92.png"
                        }
                        ],
                        "calendar": [
                        {
                        "density": "low",
                        "href": "http://playuplogos-dev.s3.amazonaws.com/team-logos/american_football/american_football_cardinals_ari_1333419218_35x23.png"
                        },
                        {
                        "density": "medium",
                        "href": "http://playuplogos-dev.s3.amazonaws.com/team-logos/american_football/american_football_cardinals_ari_1333419218_53x35.png"
                        },
                        {
                        "density": "high",
                        "href": "http://playuplogos-dev.s3.amazonaws.com/team-logos/american_football/american_football_cardinals_ari_1333419218_70x46.png"
                        }
                        ]
                        }
                      },
          "statistics": {
            "played": 3,
            "won": 1,
            "drawn": 2,
            "lost": 0,
            "goals_for": 5,
            "goals_against": 2,
            "difference": 3,
            "points": 9
          }
        },
        {
          "position":2,
          "group_name": "Group A",
            "team":{  
              ":self": "http://localhost:3000/teams/525",
                      ":type": "application/vnd.playup.sport.team+json",
                      ":uid": "team-525",
                      "display_name": "Mets",
                      "name": "New York",
                      "short_name": "NYM",
                      "logos": {
                        "header": [
                        {
                        "density": "low",
                        "href": "http://playuplogos-dev.s3.amazonaws.com/team-logos/american_football/american_football_cardinals_ari_1333419218_70x46.png"
                        },
                        {
                        "density": "medium",
                        "href": "http://playuplogos-dev.s3.amazonaws.com/team-logos/american_football/american_football_cardinals_ari_1333419218_105x69.png"
                        },
                        {
                        "density": "high",
                        "href": "http://playuplogos-dev.s3.amazonaws.com/team-logos/american_football/american_football_cardinals_ari_1333419218_140x92.png"
                        }
                        ],
                        "calendar": [
                        {
                        "density": "low",
                        "href": "http://playuplogos-dev.s3.amazonaws.com/team-logos/american_football/american_football_cardinals_ari_1333419218_35x23.png"
                        },
                        {
                        "density": "medium",
                        "href": "http://playuplogos-dev.s3.amazonaws.com/team-logos/american_football/american_football_cardinals_ari_1333419218_53x35.png"
                        },
                        {
                        "density": "high",
                        "href": "http://playuplogos-dev.s3.amazonaws.com/team-logos/american_football/american_football_cardinals_ari_1333419218_70x46.png"
                        }
                        ]
                        }
                      },
          "statistics": {
            "played": 2,
            "won": 3,
            "drawn": 2,
            "lost": 3,
            "goals_for": 5,
            "goals_against": 2,
            "difference": 3,
            "points": 9
          }
        },
        {
          "position":1,
          "group_name": "Group B",
            "team":{  
              ":self": "http://localhost:3000/teams/525",
                      ":type": "application/vnd.playup.sport.team+json",
                      ":uid": "team-525",
                      "display_name": "Cardinals",
                      "name": "Arizona",
                      "short_name": "ARI",
                      "logos": {
                        "header": [
                        {
                        "density": "low",
                        "href": "http://playuplogos-dev.s3.amazonaws.com/team-logos/american_football/american_football_cardinals_ari_1333419218_70x46.png"
                        },
                        {
                        "density": "medium",
                        "href": "http://playuplogos-dev.s3.amazonaws.com/team-logos/american_football/american_football_cardinals_ari_1333419218_105x69.png"
                        },
                        {
                        "density": "high",
                        "href": "http://playuplogos-dev.s3.amazonaws.com/team-logos/american_football/american_football_cardinals_ari_1333419218_140x92.png"
                        }
                        ],
                        "calendar": [
                        {
                        "density": "low",
                        "href": "http://playuplogos-dev.s3.amazonaws.com/team-logos/american_football/american_football_cardinals_ari_1333419218_35x23.png"
                        },
                        {
                        "density": "medium",
                        "href": "http://playuplogos-dev.s3.amazonaws.com/team-logos/american_football/american_football_cardinals_ari_1333419218_53x35.png"
                        },
                        {
                        "density": "high",
                        "href": "http://playuplogos-dev.s3.amazonaws.com/team-logos/american_football/american_football_cardinals_ari_1333419218_70x46.png"
                        }
                        ]
                        }
                      },
          "statistics": {
            "played": 3,
            "won": 1,
            "drawn": 2,
            "lost": 0,
            "goals_for": 5,
            "goals_against": 2,
            "difference": 3,
            "points": 9
          }
        }
        ]
    }
}

    @standing = FootballStandings.new JSON(json)

    haml :"football"
  end 
end