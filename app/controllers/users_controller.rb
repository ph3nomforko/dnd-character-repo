class UsersController < ApplicationController

    get '/login' do # Render login page
        erb :login
    end

    post '/login' do # Receive login form, find the user, and create a session
        @user = User.find_by(email: params[:email])
        if @user.authenticate(params[:password])
            
        else
            # Give error message if wrong credentials
        end
    end

    get '/signup' do

    end

end