class ReportsController < ApplicationController

  get '/reports/new' do
    erb :'reports/new'
  end

end
