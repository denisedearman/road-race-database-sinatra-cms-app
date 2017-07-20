require 'spec_helper'

describe ReportsController do
  before do
    newbie = User.create(username: "average joe", email: "john@smith.com", password: "password123")
    turkey_trot = Race.create(name: "Turkey Trot Orlando", location: "Orlando, FL", next_race_day: "November 23rd, 2017", distance: "5k")
    first_5k = Report.create(user: newbie, race: turkey_trot, title: "first race", score: 5, year: 2015, content: "great first race. lot's of cobblestone though.", runs_per_week: 3, miles_per_week: 12)
  end

  after do
    Report.destroy_all
  end

  describe "Create Report Page" do

    context 'logged in' do

      it 'allows you to view a form to create a new report' do
        user = User.create(:username => "trackstar", :email => "ilovetorun@aol.com", :password => "shoes")

        visit '/login'

        fill_in(:username, :with => "trackstar")
        fill_in(:password, :with => "shoes")
        click_button 'submit'

        visit '/reports/new'
        expect(page.body).to include('<form')
        expect(page.body).to include('report[title]')
        expect(page.body).to include('report[score]')
        expect(page.body).to include('report[year]')
        expect(page.body).to include('report[content]')
        expect(page.body).to include('report[runs_per_week]')
        expect(page.body).to include('report[miles_per_week]')
        expect(page.body).to include('report[race_id]')
        expect(page.body).to include('race[name]')
        expect(page.body).to include('race[location]')
        expect(page.body).to include('race[next_race_day]')
        expect(page.body).to include('race[distance]')
      end


      it 'allows you to create a report with a race' do
        user = User.create(:username => "trackstar", :email => "ilovetorun@aol.com", :password => "shoes")

        visit '/login'

        fill_in(:username, :with => "trackstar")
        fill_in(:password, :with => "shoes")
        click_button 'submit'

        visit '/reports/new'
        fill_in :report_title, with: "Best Race Ever"
        fill_in :report_score, with: 5
        fill_in :report_year, with: 2015
        fill_in :report_content, with: "The BEST RACE EVER"
        fill_in :report_runs_per_week, with: 5
        fill_in :report_miles_per_week, with: 35
        choose("race_#{Race.first.id}", visible: false)
        click_button "Create New Report"
        report = Report.last
        expect(Report.all.count).to eq(2)
        expect(report.title).to eq("Best Race Ever")
        expect(report.score).to eq(5)
        expect(report.year).to eq(2015)
        expect(report.content).to eq("The BEST RACE EVER")
        expect(report.runs_per_week).to eq(5)
        expect(report.miles_per_week).to eq(35)
        expect(report.race).to eq(Race.last)
      end

      it 'allows you to create a report with a new race' do
        user = User.create(:username => "trackstar", :email => "ilovetorun@aol.com", :password => "shoes")

        visit '/login'

        fill_in(:username, :with => "trackstar")
        fill_in(:password, :with => "shoes")
        click_button 'submit'

        visit '/reports/new'
        fill_in :report_title, with: "Best Race Ever"
        fill_in :report_score, with: 5
        fill_in :report_year, with: 2015
        fill_in :report_content, with: "The BEST RACE EVER"
        fill_in :report_runs_per_week, with: 5
        fill_in :report_miles_per_week, with: 35
        choose "race_0"
        fill_in :new_race_name, with: "Santa Claus 5k"
        fill_in :new_race_location, with: "Tampa, FL"
        fill_in :new_race_next_race_day, with: "December 25th, 2017"
        fill_in :new_race_distance, with: "5k"
        click_button "Create New Report"
        report = Report.last
        race = Race.last
        expect(Report.all.count).to eq(2)
        expect(report.title).to eq("Best Race Ever")
        expect(report.score).to eq(5)
        expect(report.year).to eq(2015)
        expect(report.content).to eq("The BEST RACE EVER")
        expect(report.runs_per_week).to eq(5)
        expect(report.miles_per_week).to eq(35)
        expect(report.race).to eq(race)
      end
    end
    context 'logged out' do
      it 'does not let a user creat a new report if not logged in' do
        get '/reports/new'
        expect(last_response.location).to include("/login")
      end
    end
  end

  describe 'Show Report Page' do
    context 'logged in' do

      it 'allows you to see a single report' do
        user = User.create(:username => "trackstar", :email => "ilovetorun@aol.com", :password => "shoes")

        visit '/login'

        fill_in(:username, :with => "trackstar")
        fill_in(:password, :with => "shoes")
        click_button 'submit'

        report = Report.find_by(title: "first race")
        visit "/reports/#{report.id}"

        expect(page.body).to include(report.title)
        expect(page.body).to include(report.content)
        expect(page.body).to include(report.score.to_s)
        expect(page.body).to include(report.year.to_s)
        expect(page.body).to include(report.user.username)
        expect(page.body).to include(report.race.name)
      end
    end

    context 'logged out' do
      it 'does not allow you to see a single report' do
        report = Report.find_by(title: "first race")
        get "/reports/#{report.id}"
        expect(last_response.location).to include("/login")
      end
    end
  end

end
