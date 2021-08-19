class UsersController < ApplicationController

    get '/login' do # Render login page
        puts flash
        erb :login
    end

    post '/login' do # Receive login form, find the user, and create a session
        @user = User.find_by(email: params[:email])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect "/users/#{@user.id}"
        else
            flash[:message] = "Your credentials were invalid. Please signup or try again."
            redirect '/login'
        end
    end

    get '/signup' do # Render the signup page
        erb :signup
    end

    post '/users' do
        if params[:name] != "" && params[:email] != "" && params[:password] != ""
            @user = User.create(params)
            session[:user_id] = @user.id
            redirect "/users/#{@user.id}"
        else
            redirect '/signup'
        end
    end

    get '/users/:id' do
        @user = User.find_by(id: params[:id])
        erb :'/users/show'
    end

    get '/logout' do
        session.clear
        redirect '/'
    end

end