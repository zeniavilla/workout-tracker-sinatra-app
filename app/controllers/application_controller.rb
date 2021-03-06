require 'rack-flash'
require 'sinatra/activerecord'

class ApplicationController < Sinatra::Base
    configure do
        set :public_folder, 'public'
        set :views, 'app/views'
        enable :sessions
        set :session_secret, 'workout-tracker'
    end
    use Rack::Flash

    get '/' do
        erb :index
    end
    
    helpers do
        def logged_in?
            !!current_user
        end
        
        def current_user
            @current_user ||= User.find_by(id: session[:id]) if session[:id]
        end
        
    end

end