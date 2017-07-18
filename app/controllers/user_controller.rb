class UserController < ApplicationController

  get '/signup' do
    erb :'/users/new'
  end

  post '/signup' do
    if params[:username].empty? || params[:password].empty? || params[:email].empty?
      redirect '/signup'
    else
      User.create(username: params[:username], password: params[:password])
      redirect '/races'
    end
  end


end
