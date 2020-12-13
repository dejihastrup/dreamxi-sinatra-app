class TeamsController < ApplicationController

    before '/teams/*' do 
        authentication_required
    end

    get '/teams' do  
        @teams = current_user.teams
        erb :'teams/index'
    end

    get '/teams/new' do
        erb :'teams/new' 
    end

    post '/teams/new' do 
        @team = Team.new(:name => params[:name], :formation => params[:formation].to_i)
        @team.user = current_user
        if @team.save
            redirect to "/teams/#{@team.id}"
        else
            redirect to '/teams/new'
        end
    end

    get "/teams/:id" do
        @team = current_user.teams.find(params[:id])
        erb :'teams/show'
    end

    # patch '' do 
    # end

    # delete '' do 
    # end
end