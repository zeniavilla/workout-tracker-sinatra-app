class WorkoutsController < ApplicationController

    get '/workouts/index' do
        if logged_in?
            @user = current_user(session)
            erb :'/workouts/index'
        else
            flash[:please_login] = "You need to be logged in to continue."
            redirect "/users/login"
        end
    end

    get '/workouts/new' do
        if logged_in?(session)
            erb :'/workouts/new'
        else
            flash[:please_login] = "You need to be logged in to continue."
            redirect "/users/login"
        end
    end

    post '/workouts/new' do
        @workout = Workout.new(date: params[:date], activity_description: params[:activity_description], duration: params[:duration])
        @workout.save
        if @workout.save
            current_user(session).workouts << @workout
            flash[:success_added] = "Successfully added workout."
            redirect "/workouts/#{@workout.id}"
        else
            flash[:error_workout] = "Please enter a valid date, activity description, and duration."
            redirect '/workouts/new'
        end
    end

    get '/workouts/:id' do
        @workout = Workout.find(params[:id])
        if @workout.user_id == current_user(session).id
            erb :'/workouts/show'
        else
            flash[:error_own_workouts] = "You can only view your own workouts."
            redirect '/workouts/index'
        end
    end

    get '/workouts/:id/edit' do
        @workout = Workout.find(params[:id])
        if @workout.user_id == current_user(session).id
            erb :'/workouts/edit'
        else
            flash[:error_own_workouts] = "You can only edit your own workouts."
            redirect '/workouts/index'
        end
    end

    patch '/workouts/:id/edit' do
        @workout = Workout.find(params[:id])
        @workout.update(date: params[:date], activity_description: params[:activity_description], duration: params[:duration])
        flash[:success_edited] = "Successfully edited workout."
        redirect "/workouts/#{@workout.id}"
    end

end