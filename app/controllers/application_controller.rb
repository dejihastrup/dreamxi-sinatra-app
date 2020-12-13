require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secure_session"
    register Sinatra::Flash
  end

  get '/' do
    if !logged_in? 
      erb :welcome
    else
      redirect to "/users/#{current_user.slug}"
    end
  end

  helpers do 

    def logged_in?
      !!current_user
    end

    def current_user
      @user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def authentication_required
      if !logged_in?
        flash[error] ="You can't make if team if you're not logged in!"
        redirect to '/'
      end
    end

  end

end
