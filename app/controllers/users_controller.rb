require 'rack-flash'

class UsersController < ApplicationController
    use Rack::Flash

    get '/users/signup' do
        erb :'/users/signup'
    end

    post '/users/signup' do
        @user = User.new(username: params[:username], email: params[:email], password: params[:password])
        @user.save
        if @user.save
            session[:id] = @user.id
            flash[:success_login] = "Successfully created account."
            redirect "/workouts/index"
        else
            flash[:error_signup] = "Please enter a username, email, and password."
            redirect back
        end
    end
    
    get '/users/login' do
        erb :'/users/login'
    end

    post '/users/login' do
        @user = User.find_by(username: params[:username])
        if @user && @user.authenticate(params[:password])
            session[:id] = @user.id
            redirect "/workouts/index"
        else
            flash[:error_login] = "Please enter a valid username and password."
            redirect back
        end
    end
    
end