class WelcomeController < ApplicationController

  before_action :authenticate_user, only: [:home] 
      #user will only be authenticated before going to homepage
      #to ensure that only users can see homepage
  
  def home
  end

  private

  def authenticate_user
    redirect_to sign_in_path if signed_out?
  end

end


