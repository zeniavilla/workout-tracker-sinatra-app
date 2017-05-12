class WorkoutsController < ApplicationController

    get '/workouts/index' do
        if logged_in?(session)
            @user = current_user(session)
            erb :'/workouts/index'
        else
            redirect "/users/login"
        end
    end

    get '/workouts/new' do
        if logged_in?(session)
            erb :'/workouts/new'
        else
            redirect "/users/login"
        end
    end

end