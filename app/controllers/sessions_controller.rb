#file and codes added on Sept 16

class SessionsController < Clearance::SessionsController

  def create_from_omniauth
    auth_hash = request.env["omniauth.auth"]
    # byebug

    authentication = Authentication.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"]) || Authentication.create_with_omniauth(auth_hash)
    
        #but, if the authentication record has existed, then it will go here
    if authentication.user
      user = authentication.user 
      authentication.update_token(auth_hash)
      @next = root_url #this will redirect to root 'welcome#home'
      # @notice = "Welcome back, #{user.firstname}!" #just for testing.
    else
      #I believe that this is what happens when the record hasnt existed before
      user = User.create_with_auth_and_hash(authentication,auth_hash)
      @next = root_url   #ori: edit_user_path(user) 
      #@notice = "PairBnb account successfully created via FB!" #ori: "User created - confirm or edit details..."
    end

    sign_in(user)
    redirect_to @next, :notice => @notice
  end

end

