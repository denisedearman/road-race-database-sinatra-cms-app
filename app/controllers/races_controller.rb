require 'rack-flash'
class RacesController < ApplicationController
  use Rack::Flash
  get '/races' do
    if !logged_in?
      redirect '/login'
    else
      @races = Race.all
      erb :'races/index'
    end
  end

  post '/races' do
    if !logged_in?
      redirect '/login'
    elsif params[:race][:name] == ""
      flash[:message] = "Your new race could not be saved without a name."
      redirect '/races/new'
    else
      Race.create(params[:race])
      redirect '/races'
    end
  end

  get '/races/new' do
    if !logged_in?
      redirect '/login'
    else
      erb :'races/new'
    end
  end

  get '/races/:slug' do
    if !logged_in?
      redirect '/login'
    else
      @race = Race.find_by_slug(params[:slug])
      erb :'races/show'
    end
  end


end
