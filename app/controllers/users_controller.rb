class UsersController < ApplicationController

    get '/users/signup' do
        erb :'/users/signup'
    end

    post '/users/signup' do
        if User.find_by(username: params[:username]) && User.find_by(email: params[:email])
            flash[:error] = "Username and/or email is already taken."
        else
            @user = User.new(username: params[:username], email: params[:email], password: params[:password])
            if @user.save
                session[:id] = @user.id
                flash[:success] = "Successfully created account."
                redirect "/workouts/index"
            else
                flash[:error] = "Please enter a valid username, email, and password."
                redirect back
            end
        end
    end
    
    get '/users/signin' do
        erb :'/users/signin'
    end

    post '/users/signin' do
        @user = User.find_by(username: params[:username])
        if @user && @user.authenticate(params[:password])
            session[:id] = @user.id
            redirect "/workouts/index"
        else
            flash[:error] = "Please enter a valid username and password."
            redirect back
        end
    end

    get '/users/signout' do
        if logged_in?
            session.clear
            flash[:success] = "Successfully logged you out."
            redirect to '/'
        else
            redirect to '/'
        end
    end
    
end