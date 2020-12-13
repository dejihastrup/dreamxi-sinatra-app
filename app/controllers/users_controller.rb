class UsersController < ApplicationController

    get '/signup' do 
        erb :'users/signup'  
    end

    post '/signup' do 
        @user = User.new(username: params[username], password: params[password])
        if @user.save
            session[user_id] = @user.id
            redirect to '/users/#{session[user_id]}'
        else
            erb :'errors/signup'
        end
    end

    get '/login' do
        erb :'/users/login'
    end

    post '/login' do
        @user = User.find_by(:username => params[username])

        if @user && @user.authenticate(params[password])
            sessions[user_id] = @user.id
            redirect to '/users/#{session[user_id]}'
        else
            redirect to '/login'
        end
    end
end