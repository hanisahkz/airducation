class UsersController < Clearance::UsersController



  #is it, when it's referred as: users#create. Yep!
  def create 
    #byebug #to check params
    @user = User.new(user_params)   #strong params required here 

    if @user.save
      sign_in @user
      redirect_back_or url_after_create     #this part ??
    else
      render template: "users/new"  #not too sure about this
    end
  end

  private 

  #main purpose of strong params: to avoid receiving error: ActiveModel::ForbiddenAttributesError
  #it's a good practice to put strong params after privates
  #arguments used are based on how you named them in migration table 
  def user_params
    params.require(:user).permit(:firstname, :lastname, :birthday, :email, :password)
  end

end

  