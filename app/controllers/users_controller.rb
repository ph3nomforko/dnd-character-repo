class UsersController < ApplicationController
    
    get '/login' do
        erb :login
    end

    post '/login' do
        @user = User.find_by(email: params[:email])
        if @user && @user.authenticate(params[:password])
            flash[:message] = "Login successful. Welcome back!"
            session[:user_id] = @user.id
            redirect "/users/#{@user.id}"
        else
            flash[:error] = "Your credentials were invalid. #{@user.errors.full_messages.to_sentence}."
            redirect '/login'
        end
    end

    get '/signup' do
        erb :signup
    end

    post '/users' do
        @user = User.new(params)
        if @user.save
            flash[:message] = "Welcome #{@user.name} to your new D&D character repository!"
            session[:user_id] = @user.id
            redirect "/characters/new"
        else
            flash[:error] = "Account creation failed. #{@user.errors.full_messages.to_sentence}."
            redirect '/signup'
        end
    end

    get '/users/:id' do
        @user = User.find_by(id: params[:id])
        redirect_if_not_logged_in
        erb :'/users/show'
    end

    get '/logout' do
        session.clear
        redirect '/'
    end

end