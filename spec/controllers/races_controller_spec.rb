require 'spec_helper'

describe RacesController do

  before do
    st_george = Race.create(name: "St George Marathon", location: "St George, Utah", next_race_day: "October 7th, 2017", distance: "marathon")
    princess_half = Race.create(name: "Disney Princess Half Marathon", location: "Orlando, FL", next_race_day: "February 25th, 2018", distance: "half marathon")
  end

  after do
    Race.destroy_all
  end

  describe 'Index Page' do

    context 'logged in' do

      it 'allows you to view all races' do
        
      end

    end

  end




end
