class CharactersController < ApplicationController
    
    get '/characters' do
        @characters = current_user.characters
        redirect_if_not_logged_in
        erb :'characters/index'
    end
    
    get '/characters/new' do
        erb :'/characters/new'
    end

    get '/characters/all' do
        @characters = Character.all
        erb :'/characters/all'
    end

    post '/characters' do
        redirect_if_not_logged_in

        @character = Character.new(character_name: params[:character_name], character_class: params[:character_class],
            species: params[:species], level: params[:level], user_id: current_user.id)
        if @character.save
            flash[:message] = "You've successfully created a new character!"
            redirect "/characters/#{@character.id}"
        else
            flash[:error] = "Character creation failed. #{@character.errors.full_messages.to_sentence}."
            redirect '/characters/new'
        end
    end

    get '/characters/:id' do
        find_and_set_character
        erb :'/characters/show'
    end

    get '/characters/:id/edit' do
        find_and_set_character
        redirect_if_not_logged_in
        if authorized_to_edit?(@character)
            erb :'/characters/edit'
        else
            redirect "/users/#{current_user.id}"
        end
    end

    patch '/characters/:id' do
        find_and_set_character
        redirect_if_not_logged_in
        if authorized_to_edit?(@character) && @character.valid?
            flash[:message] = "You've successfully updated your character!"
            @character.update(character_name: params[:character_name], character_class: params[:character_class],
                species: params[:species], level: params[:level])
            redirect "/characters/#{@character.id}"
        else
            flash[:error] = "Please check your character's vitals and try again."
            redirect "/characters/#{@character.id}"
        end
    end

    delete '/characters/:id' do
        find_and_set_character
        if authorized_to_edit?(@character)
            @character.destroy
            flash[:message] = "You successfully deleted the character."
            redirect '/characters'
        else
            flash[:error] = "You are not authorized to edit or delete that character."
            redirect '/characters'
        end
    end

    private
    def find_and_set_character
        @character = Character.find(params[:id])
    end

end