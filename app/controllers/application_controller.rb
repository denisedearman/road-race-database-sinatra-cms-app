class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  enable :sessions
  set :session_secret, "race_secrets"
  set :views, Proc.new { File.join(root, "../views/") }


end
