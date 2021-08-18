class UsersController < ApplicationController

    get '/login' do # Render login page
        erb :login
    end

    get '/signup' do

    end

end