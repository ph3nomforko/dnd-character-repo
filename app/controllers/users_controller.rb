class UsersController < ApplicationController

    get '/login' do # Render login page
        erb :login
    end

    post '/login' do # Receive login form, find the user, and create a session
        @user = User.find_by(email: params[:email])
        if @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect "/users/#{@user.id}"
        else
            # Give error message if wrong credentials
        end
    end

    get '/signup' do

    end

    get '/users/:id' do
        "User show page"
    end

end