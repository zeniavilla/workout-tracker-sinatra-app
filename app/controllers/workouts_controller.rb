class WorkoutsController < ApplicationController

    get '/workouts/index' do
        if logged_in?
            @user = current_user
            erb :'/workouts/index'
        else
            flash[:error] = "You need to be logged in to continue."
            redirect "/users/signin"
        end
    end

    get '/workouts/new' do
        if logged_in?
            erb :'/workouts/new'
        else
            flash[:error] = "You need to be logged in to continue."
            redirect "/users/signin"
        end
    end

    post '/workouts/new' do
        @workout = Workout.new(date: params[:date], activity_description: params[:activity_description], duration: params[:duration])
        if @workout.save
            current_user.workouts << @workout
            flash[:success] = "Successfully added workout."
            redirect "/workouts/#{@workout.id}"
        else
            flash[:error] = "Please enter a valid date, activity description, and duration."
            redirect '/workouts/new'
        end
    end

    get '/workouts/:id' do
        @workout = Workout.find(params[:id])
        if @workout.user_id == current_user.id
            erb :'/workouts/show'
        else
            flash[:error] = "You can only view your own workouts."
            redirect '/workouts/index'
        end
    end

    get '/workouts/:id/edit' do
        @workout = Workout.find(params[:id])
        if @workout.user_id == current_user.id
            erb :'/workouts/edit'
        else
            flash[:error] = "You can only edit your own workouts."
            redirect '/workouts/index'
        end
    end

    patch '/workouts/:id/edit' do
        @workout = Workout.find(params[:id])
        @workout.update(date: params[:date], activity_description: params[:activity_description], duration: params[:duration])
        flash[:success] = "Successfully edited workout."
        redirect "/workouts/#{@workout.id}"
    end

    delete '/workouts/:id/delete' do
        @workout = Workout.find(params[:id])
        @workout.destroy
        flash[:success] = "Successfully deleted workout."
        redirect '/workouts/index'
    end

end


# Todo:

#1.  Add a persisting navbar that show different links depending on if a user logged_in?
#2.  Clean up code that passes session as an argument
#3.  Clean up duplicate code in your controllers and views