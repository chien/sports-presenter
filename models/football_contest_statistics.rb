class SportsPresentation::FootballContestStatistics

  def initialize(contest_data, event_data)
    @contest_data, @event_data = contest_data, event_data
  end

  def self.fetch(contest_id)
    contest_data = SportsApiClient.fetch("/contest_details/#{contest_id}")
    events = SportsApiClient.fetch("/contests/#{contest_id}/events")
        @scope = [:statistics, @hash[:sport_name].downcase.to_sym]      
        @goals = goals if contest.sport == Sport.football
        haml "contests/show"  
    new(contest_data, events)
  end

  def home_team_statistics
    
  end

  def away_team_statistics
    
  end

  def goal_rundown
    
  end
def goals
    all_goals = []
    @hash[:scores].each do |sides|
      goals = group_goals_by_by_scorer(sides[:goals])
      goals.each do |goal| 
        goal[:team] = sides[:team][:short_name]
      end    
      all_goals += goals
    end
    all_goals.sort do |a, b| 
      b[:goal_times].first[:minutes] <=> a[:goal_times].first[:minutes]
    end
  end

  def group_goals_by_by_scorer(goals)
    grouped_goals = []
    goals.each do |goal| 
      goal[:goal_times] = [
                            {:minutes => goal[:minutes],
                             :additional_minutes => goal[:additional_minutes],
                             :type => goal[:type] 
                            }
                          ]
      
      if duplicate = grouped_goals.detect{|exists| exists[:player_first_name] == goal[:player_first_name] && exists[:player_last_name] == goal[:player_last_name]}
         duplicate[:goal_times] = (duplicate[:goal_times] << goal[:goal_times].first).sort{|a, b| b[:minutes]<=>a[:minutes]}
      else
        grouped_goals << goal
      end      
    end
    grouped_goals
  end

  def set_layout
    "empty" unless params[:format].nil?
  end


end