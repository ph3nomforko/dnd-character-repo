class UsersController < ApplicationController

    get '/login' do # Render login page
        erb :login
    end

    post '/login' do # Receive login form, find the user, and create a session
        
    end

    get '/signup' do

    end

end