class CharactersController < ApplicationController
    
    get '/characters' do
        @characters = Character.all
        if logged_in?
            erb :'characters/index'
        else
           redirect '/'
        end
    end
    
    get '/characters/new' do
        erb :'/characters/new'
    end#

    post '/characters' do
        if !logged_in?
            redirect '/'
        end

        if params[:character_name] != "" && params[:character_class] != "" && params[:species] != "" && params[:level] != ""
            flash[:message] = "You've successfully created a new character!"
            @character = Character.create(character_name: params[:character_name], character_class: params[:character_class],
                species: params[:species], level: params[:level], user_id: current_user.id)
            redirect "/characters/#{@character.id}"
        else
            flash[:message] = "Please check your character's vitals and try again."
            redirect '/characters/new'
        end
    end

    get '/characters/:id' do
        find_and_set_character
        erb :'/characters/show'
    end

    get '/characters/:id/edit' do
        find_and_set_character
        if logged_in?
            if authorized_to_edit?(@character)
                erb :'/characters/edit'
            else
                redirect "/users/#{current_user.id}"
            end
        else
            redirect '/'
        end
    end

    patch '/characters/:id' do
        find_and_set_character
        if logged_in?
            if authorized_to_edit?(@character) && params[:character_name] != "" && params[:character_class] != "" && params[:species] != "" && params[:level] != ""
                flash[:message] = "You've successfully updated your character!"
                @character.update(character_name: params[:character_name], character_class: params[:character_class],
                    species: params[:species], level: params[:level])
                redirect "/characters/#{@character.id}"
            else
                flash[:message] = "Please check your character's vitals and try again."
                redirect "/characters/#{@character.id}"
            end
        else
            redirect '/'
        end
    end

    delete '/characters/:id' do
        find_and_set_character
        if authorized_to_edit?(@character)
            @character.destroy
            redirect '/characters'
        else
            redirect '/characters'
        end
    end

    private
    def find_and_set_character
        @character = Character.find(params[:id])
    end

end