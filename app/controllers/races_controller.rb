class RacesController < ApplicationController

  get '/races' do
    if logged_in?
      @races = Race.all
      erb :'races/index'
    else
      redirect '/login'
    end
  end


end
