class WorkoutsController < ApplicationController

    get '/workouts/index' do
        if logged_in?(session)
            @user = current_user(session)
            erb :'/workouts/index'
        else
            flash[:please_login] = "You need to be logged in to do that."
            redirect "/users/login"
        end
    end

    get '/workouts/new' do
        if logged_in?(session)
            erb :'/workouts/new'
        else
            flash[:please_login] = "You need to be logged in to do that."
            redirect "/users/login"
        end
    end

    post '/workouts/new' do
        @workout = Workout.new(date: params[:date], activity_description: params[:activity_description], duration: params[:duration])
        @workout.save
        if @workout.save
            current_user(session).workouts << @workout
            redirect '/workouts/index'
        else
            flash[:error_workout] = "Please enter a valid date, activity description, and duration."
            redirect '/workouts/new'
        end
    end

    get '/workouts/:id' do
        @workout = Workout.find(params[:id])
        erb :'/workouts/show'
    end

end