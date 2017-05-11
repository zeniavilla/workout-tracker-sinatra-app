class UsersController < ApplicationController

    get '/users/signup' do
        erb :'/users/signup'
    end

    post '/users/signup' do
        @user = User.new(username: params[:username], email: params[:email], password: params[:password])
        @user.save
        if @user.save
            redirect "/workouts/index"
        else
            redirect back
        end
    end
    
    get '/users/login' do
        erb :'/users/login'
    end

    
end