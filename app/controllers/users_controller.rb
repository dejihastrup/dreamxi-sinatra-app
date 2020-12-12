class UsersController < ApplicationController

    get '/signup' do 
        erb :'users/signup'  
    end

    post 'users' do 
        @user = User.new(username: params[username], password: params[password])
        if @user.save
            redirect to '/users/#{@user.id}'
        else
            erb :'errors/signup'
    end
end