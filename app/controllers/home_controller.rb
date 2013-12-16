class HomeController < ApplicationController
  def index
    
   # @circles = Unit.all
    if logged_in?
      auth = Signet::Rails::Factory.create_from_env :google, request.env
      client = Google::APIClient.new
      client.authorization = auth
      plusDomain = client.discovered_api('plusDomains')
      
      if params[:type] && params[:type] == 'add_people' && params[:email]
        @result = client.execute(
          :api_method => plusDomain.circles.add_people,
          :parameters => {'circleId' => params[:circle_id], 'email' => params[:email]}
        )
        debugger
        unit = Unit.find_by_circle_id(params[:circle_id])
        #unit.user_id = 
      elsif params[:id] && params[:id] == 'remove_people'
        @result = client.execute(
          :api_method => plusDomain.circles.remove_people,
          :parameters => {'circleId' => '20ff55a68a49bd9a', 'userId' => '100035974027688113487'}
        )
      elsif params[:type] && params[:type] == 'create_circle' && params[:circle_name]
        @result = client.execute(:api_method => plusDomain.circles.insert,
          :parameters => {'userId' => 'me'},
          :body =>MultiJson.dump('displayName' => params[:circle_name]),
          :headers => {'Content-Type' => 'application/json'}
        )
        Unit.create(:circle_id => @result.data.id,:circle_name => @result.data.displayName);
      elsif params[:id] && params[:id] == 'update'
         @result = client.execute(:api_method => plusDomain.circles.update,
           :parameters => {'circleId'=>'433bbe740880d65c'},
           :body =>MultiJson.dump('displayName' => 'TestingChange'),
           :headers => {'Content-Type' => 'application/json'}
         )
      elsif params[:id] && params[:id] == 'delete'
        @result = client.execute(
          :api_method => plusDomain.circles.remove,
          :parameters => {'circleId' => '1e4924048811dc76'}
        )
      end
        @result = client.execute(
          :api_method => plusDomain.circles.list,
          :parameters => {'userId' => 'me'}
        )
      if !@result.nil?
        @result.data.items.each do |result|
          unless Unit.find_by_circle_id(result.id)
            Unit.create(:circle_id => result.id,:circle_name => result.displayName);
          end
        end
      end
    
    end
  end
  
end
