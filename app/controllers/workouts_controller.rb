class WorkoutsController < ApplicationController

    get '/workouts/index' do
        @user = current_user(session)
        erb :'/workouts/index'
    end

end