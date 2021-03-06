class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  enable :sessions
  set :session_secret, "race_secrets"
  set :views, Proc.new { File.join(root, "../views/") }

  get '/' do
    if logged_in?
      redirect '/races'
    else
      erb :index
    end
  end

  helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      @current_user = User.find_by(id: session[:user_id]) if session[:user_id]
    end

  end


end
