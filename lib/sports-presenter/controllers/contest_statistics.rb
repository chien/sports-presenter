module SportsPresentation
  class Application < Sinatra::Base
    get '/contests/:id/statistics' do
      @object = FootballContestStatistics.fetch(params[:id])
      @scope = [:statistics, @hash[:sport_name].downcase.to_sym]      
      @goals = goals
      haml :football_statistics
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


    #tests
    # describe 'group_goals_by_by_scorer' do
    #   it '' do
    #     subject.group_goals_by_by_scorer([]).should eql []
    #   end

    #   it 'create the goal_times hash value from the incoming elements' do
    #     goals = subject.group_goals_by_by_scorer([{:minutes =>1, :additional_minutes=>nil, :type => :goal}])
    #     goals.first[:goal_times].should eql [{:minutes=>1, :additional_minutes=>nil, :type=>:goal}]
    #   end
    #   it 'group the goals of a single player and order them in decending order them latest goal to first' do
    #     goals = subject.group_goals_by_by_scorer([{:player_first_name => "john",:player_last_name => "smith", :minutes =>1, :additional_minutes=>nil, :type => :goal},
    #                                               {:player_first_name => "john",:player_last_name => "smith", :minutes =>5, :additional_minutes=>nil, :type => :goal}])
    #     goals.first[:goal_times].should_not eql [{:minutes=>1, :additional_minutes=>nil, :type=>:goal},{:minutes=>5, :additional_minutes=>nil, :type=>:goal}]
    #     goals.first[:goal_times].should eql [{:minutes=>5, :additional_minutes=>nil, :type=>:goal}, {:minutes=>1, :additional_minutes=>nil, :type=>:goal}]
    #   end

    #   it 'group the goals of a single player and order them in decending order them latest goal to first and not merge other players' do
    #     goals = subject.group_goals_by_by_scorer([{:player_first_name => "john",:player_last_name => "smith", :minutes =>1, :additional_minutes=>nil, :type => :goal},
    #                                               {:player_first_name => "alfred",:player_last_name => "batman", :minutes =>10, :additional_minutes=>nil, :type => :goal},
    #                                               {:player_first_name => "john",:player_last_name => "smith", :minutes =>5, :additional_minutes=>nil, :type => :goal}])
    #     goals.first[:goal_times].should_not eql [{:minutes=>1, :additional_minutes=>nil, :type=>:goal},{:minutes=>5, :additional_minutes=>nil, :type=>:goal}]
    #     goals.first[:goal_times].should eql [{:minutes=>5, :additional_minutes=>nil, :type=>:goal}, {:minutes=>1, :additional_minutes=>nil, :type=>:goal}]
    #     goals.size.should eql 2
    #   end
    # end  
  end
end