class UsersController < ApplicationController

  get '/login' do
    if !logged_in?
      erb :'/users/login'
    else
      redirect '/races'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/races'
    else
      redirect '/login'
    end
  end

  get '/logout' do
    if !logged_in?
      redirect '/'
    else
      session.clear
      redirect '/login'
    end
  end

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
