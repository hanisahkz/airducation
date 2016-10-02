Rails.application.config.middleware.use OmniAuth::Builder do
      provider :facebook, ENV['APP_KEY'], ENV['APP_SECRET'] ,
      scope: 'email,user_birthday', info_fields: 'first_name,last_name,email,birthday'
        #refer FB doc for the proper syntax to use
end


  


