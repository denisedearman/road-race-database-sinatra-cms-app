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
        user = User.create(:username => "trackstar", :email => "ilovetorun@aol.com", :password => "shoes")

        visit '/login'

        fill_in(:username, :with => "trackstar")
        fill_in(:password, :with => "shoes")
        click_button 'submit'
        visit '/races'
        expect(page.body).to include("St George Marathon")
        expect(page.body).to include("Disney Princess Half Marathon")
      end
    end

    context 'logged out' do

      it 'does not allow you to view all races' do
        get '/races'
        expect(last_response.location).to include('/login')
      end
    end

  end

  describe 'Show Race Page' do

    context 'logged in' do

      it 'allows you to view race detail information' do
        user = User.create(:username => "trackstar", :email => "ilovetorun@aol.com", :password => "shoes")

        visit '/login'

        fill_in(:username, :with => "trackstar")
        fill_in(:password, :with => "shoes")
        click_button 'submit'

        race = Race.find_by(name: "St George Marathon")
        visit "/races/#{race.slug}"

        expect(page.body).to include(race.name)
        expect(page.body).to include(race.location)
        expect(page.body).to include(race.distance)
        expect(page.body).to include(race.next_race_day)
      end

      it 'allows you to view all reports on the race' do
        user = User.create(:username => "trackstar", :email => "ilovetorun@aol.com", :password => "shoes")
        race = Race.find_by(name: "St George Marathon")
        good_race = Report.create(user: user, race: race, title: "Great times", score: 5, year: 2015, content: "All the pieces fell into place", miles_per_week: 60, runs_per_week: 5)
        bad_race = Report.create(user: user, race: race, title: "Poor times", score: 2, year: 2011, content: "Bonked at mile 15", miles_per_week: 35, runs_per_week: 3)
        visit '/login'

        fill_in(:username, :with => "trackstar")
        fill_in(:password, :with => "shoes")
        click_button 'submit'


        visit "/races/#{race.slug}"
        expect(page.body).to include(good_race.title)
        expect(page.body).to include(good_race.content)
        expect(page.body).to include(good_race.score.to_s)
        expect(page.body).to include(good_race.year.to_s)
        expect(page.body).to include(bad_race.title)
        expect(page.body).to include(bad_race.content)
        expect(page.body).to include(bad_race.score.to_s)
        expect(page.body).to include(bad_race.year.to_s)
      end
    end

    context 'logged out' do
      it 'does not let you view the races show page' do
        race = Race.find_by(name: "St George Marathon")
        get "/races/#{race.slug}"
        expect(last_response.location).to include('/login')
      end
    end
  end




end
