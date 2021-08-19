class UsersController < ApplicationController
    
    get '/login' do # Render login page
        erb :login
    end

    post '/login' do # Receive login form, find the user, and create a session
        @user = User.find_by(email: params[:email])
        if @user && @user.authenticate(params[:password])
            flash[:message] = "Login successful. Welcome back!"
            session[:user_id] = @user.id
            redirect "/users/#{@user.id}"
        else
            flash[:error] = "Your credentials were invalid. Please signup or try again."
            redirect '/login'
        end
    end

    get '/signup' do
        erb :signup
    end

    post '/users' do
        @user = User.new(params)
        if @user.save
            flash[:message] = "Welcome to your new D&D character repository!"
#            @user = User.create(params)
            session[:user_id] = @user.id
            redirect "/users/#{@user.id}"
        else
            flash[:error] = "Account creation failed. #{@user.errors.full_messages.to_sentence}"
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