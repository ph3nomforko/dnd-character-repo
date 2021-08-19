class CharactersController < ApplicationController
    
    get '/characters/new' do
        erb :'/characters/new'
    end

    post '/characters' do
        if !logged_in?
            redirect '/'
        end

        if params[:character_name] != "" && params[:character_class] != "" && params[:species] != "" && params[:level] != ""
            @character = Character.create(character_name: params[:character_name], character_class: params[:character_class],
                species: params[:species], level: params[:level], user_id: current_user.id)
            redirect "/characters/#{@character.id}"
        else
            redirect '/characters/new'
        end
    end

    get '/characters/:id' do
        find_and_set_character
        erb :'/characters/show'
    end

    get '/characters/:id/edit' do
        find_and_set_character
        erb :'/characters/edit'
    end

    patch '/characters/:id' do
        # Find character
        find_and_set_character
        # Update character

        # Redirect to logical destination
    end

    private
        def find_and_set_character
            @character = Character.find_by(id: params[:id])
        end
    end
    
end