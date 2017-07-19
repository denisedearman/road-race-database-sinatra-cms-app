class UsersController < ApplicationController

  get '/signup' do
    if !logged_in?
      erb :'/users/new'
    else
      redirect '/races'
    end
  end

  post '/signup' do
    if params[:username].empty? || params[:password].empty? || params[:email].empty?
      redirect '/signup'
    else
      user = User.create(username: params[:username], password: params[:password])
      session[:user_id] = user.id
      redirect '/races'
    end
  end


end
