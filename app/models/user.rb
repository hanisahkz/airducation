
class User < ActiveRecord::Base
  include Clearance::User
  include UsersHelper #added sept16

  has_many :authentications, :dependent => :destroy
  has_many :courses, :dependent => :destroy #when a user gets deleted, so does the courses owned

  def self.create_with_auth_and_hash(authentication,auth_hash)
    create! do |u|
      u.firstname = auth_hash["info"]["first_name"].split[0]   #["info"]["first_name"] , obtained from byebug. Given by FB
      u.lastname = auth_hash["info"]["last_name"].split[-1]   #the params here MUST match how how FB name it
      u.birthday = auth_hash["extra"]["raw_info"]["birthday"] #.to_date
        #ori: auth_hash["info"]["birthday"] #this doesnt seem to be a problem, but fb not giving the info

      u.email = auth_hash["info"]["email"] 
      u.password = SecureRandom.base64(8) 
      u.authentications<<(authentication)
    end
  end

  def fb_token
    x = self.authentications.where(:provider => :facebook).first
    return x.token unless x.nil?
  end

  def password_optional?
    true
  end

  #sept 16 - solution 2 if doesnt want to use: include UsersHelper as above
    # obtained from coderwall
  # def current_user 
  #     @current_user ||= User.find(session[:user_id]) if session[:user_id]
  # end

end





