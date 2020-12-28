class UsersController < ApplicationController

    get '/signup' do 
        erb :'users/signup'  
    end

    post '/signup' do 
        
        if params[:username] == "" || params[:password] == ""
            redirect to '/signup'
        else 
            @user = User.new(username: params[:username], password: params[:password])
            if @user.save
            session[:user_id] = @user.id
            redirect to "/users/#{@user.slug}"
            end
        end
    end

    get '/login' do
        erb :'/users/login'
    end

    post '/login' do
        @user = User.find_by(:username => params[:username])

        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect to "/users/#{@user.slug}"
        else
            flash[:error] = "Oops! Looks like you've entered an incorrect username or password. Please try again."
            redirect to '/login'
        end
    end

    get "/users/:slug" do
        erb :'users/home'
    end

    get '/logout' do 
        session.destroy
        redirect to '/'
    end
end