class RacesController < ApplicationController

  get '/races' do
    if !logged_in?
      redirect '/login'
    else
      @races = Race.all
      erb :'races/index'
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
