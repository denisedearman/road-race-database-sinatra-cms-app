class ReportsController < ApplicationController

  get '/reports/new' do
    if !logged_in?
      redirect '/login'
    else
      erb :'reports/new'
    end
  end

  get '/reports' do
    if !logged_in?
      redirect '/login'
    else
      @reports = Report.all
      erb :'reports/index'
    end
  end

  post '/reports' do
    if !logged_in?
      redirect '/login'
    elsif params[:report][:race_id].to_i == 0 && params[:race][:name] == ""
      redirect '/reports/new'
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

  patch '/reports/:id' do
    if !logged_in?
      redirect '/login'
    else
      report = Report.find_by_id(params[:id])
      report.update(params[:report])
      if params[:report][:race_id].to_i == 0 || params[:race][:name] != ""
        race= Race.create(params[:race])
        report.race = race
      end
      report.save
      redirect "/reports/#{report.id}"
    end
  end

  delete '/reports/:id/delete' do
    if !logged_in?
      redirect '/login'
    else
      if current_user == Report.find_by_id(params[:id]).user
        report = Report.find_by_id(params[:id])
        report.delete
      end
      redirect "/users/#{current_user.slug}"
    end
  end

end
