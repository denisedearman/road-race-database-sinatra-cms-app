class RacesController < ApplicationController

  get '/races' do
    if logged_in?
      @races = Race.all
      erb :'races/index'
    else
      redirect '/login'
    end
  end

  get '/races/:slug' do
    if logged_in?
      @race = Race.find_by_slug(params[:slug])
      erb :'races/show'
    else
      redirect '/login'
    end
  end


end
