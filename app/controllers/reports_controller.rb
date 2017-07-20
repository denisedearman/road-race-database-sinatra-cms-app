class ReportsController < ApplicationController

  get '/reports/new' do
    if !logged_in?
      redirect '/login'
    else
      erb :'reports/new'
    end
  end

  post '/reports' do
    if !logged_in?
      redirect '/login'
    else
      report = Report.create(params[:report])
      report.user = current_user
      if params[:report][:race_id].to_i == 0
        race= Race.create(params[:race])
        report.race = race
      end
      report.save
      redirect '/reports'
    end
  end

  get '/reports/:id/edit' do
    if !logged_in?
      redirect '/login'
    elsif current_user != Report.find_by_id(params[:id]).user
      redirect '/races'
    else
      @report = Report.find_by_id(params[:id])
      erb :'reports/edit'
    end
  end

  get '/reports/:id' do
    if !logged_in?
      redirect '/login'
    else
      @report = Report.find_by_id(params[:id])
      erb :'reports/show'
    end
  end

end
