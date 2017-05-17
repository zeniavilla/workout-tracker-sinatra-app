class UsersController < ApplicationController

    get '/users/signup' do
        erb :'/users/signup'
    end

    post '/users/signup' do
        if User.find_by(username: params[:username]) && User.find_by(email: params[:email])
            flash[:error] = "Username and/or email is already taken."
        else
            @user = User.new(username: params[:username], email: params[:email], password: params[:password])
            @user.save
            if @user.save
                session[:id] = @user.id
                flash[:success_login] = "Successfully created account."
                redirect "/workouts/index"
            else
                flash[:error_signup] = "Please enter a valid username, email, and password."
                redirect back
            end
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

    get '/users/logout' do
        if logged_in?(session)
            session.clear
            flash[:logged_out] = "Successfully logged you out."
            redirect to '/'
        else
            redirect to '/'
        end
    end
    
end