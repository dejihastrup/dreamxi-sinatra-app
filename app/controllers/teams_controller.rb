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
            redirect to "/teams/#{@team.id}/players/new"
        else
            redirect to '/teams/new'
        end
    end

    
    get "/teams/:id" do
        @team = current_user.teams.find(params[:id])
        erb :'teams/show'
    end

    get "/teams/:id/players/new" do
        @team = current_user.teams.find(params[:id])
        erb :'players/new'
    end 

    post "/teams/:id/players/new" do 
        @team = current_user.teams.find(params[:id])
        binding.pry
        @players = params[:player].map do |details|
            player = Player.new(details)
            player.team = @team
            player.save
            player
        end

        redirect to "/teams/#{@team.id}"

    end

    # patch '' do 
    # end

    # delete '' do 
    # end
end