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

    get '/signup' do # Render the signup page
        erb :signup
    end

    post '/users' do
        if params[:name] != "" && params[:email] != "" && params[:password] != ""
            @user = User.create(params)
            redirect "/users/#{@user.id}"
        else
            #invalid
        end
    end

    get '/users/:id' do
        @user = User.find_by(id: params[:id])
        erb :'/users/show'
    end

end