class TeamsController < ApplicationController

    before '/teams/*' do 
        authentication_required
    end

    get '/teams' do  
        @teams = current_user.teams
        erb :'teams/index'
    end

    # Create

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
        @players = params[:player].map do |details|
            player = Player.new(details)
            player.team = @team
            player.save
            player
        end

        redirect to "/teams/#{@team.id}"

    end

    # Edit

    get "/teams/:id/edit" do 
        @team = current_user.teams.find(params[:id])
        
        erb :'teams/edit'
    end


    get "/teams/:id/edit/players" do 
        @team = current_user.teams.find(params[:id])
        
        erb :'players/edit'
    end

    patch "/teams/:id" do 
        @team = current_user.teams.find(params[:id])
        @team.update(name: params[:name], formation: params[:formation])
  
        redirect to "/teams/#{@team.id}/edit/players"
    end

    patch "/teams/:id/players" do
        @team = current_user.teams.find(params[:id]) 
        params[:player].each_with_index do |player, index|
      
            @team.players[index].update(name: player[:name], position: player[:position])
        end 
  
        redirect to "/teams"
    end

    #Delete

    get '/teams/:id/delete' do
        @team = current_user.teams.find(params[:id])
        
        erb :'teams/delete_confirmation'
    end

    delete '/teams/:id/delete' do
        @team = current_user.teams.find(params[:id])
        binding.pry
        if params[:answer] == "Go Back"
            redirect to "/teams" 
        else
            # @teams.players.each do |player|
            #     player.destroy
            # end
            # binding.pry
            @team.destroy
            redirect to "/teams" 
        end
    end
end