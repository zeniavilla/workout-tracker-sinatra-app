class ApplicationController < Sinatra::Base
    configure do
        set :public_folder, 'public'
        set :views, 'app/views'
        enable :sessions
        set :session_secret, 'workout-tracker'
    end

    get '/' do
        erb :index
    end
    
    helpers do
        def logged_in?(session)
            !!session[:id]
        end
        
        def current_user(session)
            User.find(session[:id]) if session[:id]
        end
        
    end

end