require 'spec_helper'

describe ReportsController do
  before do
    newbie = User.create(username: "average joe", email: "john@smith.com", password: "password123")
    malicious = User.create(username: "malicious", email: "messy@gmail.com", password: "stayaway")
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
        select "5", from: "report_score"
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
        select "5", from: "report_score"
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

  describe 'Delete Report' do
    context 'logged in' do

      it 'deletes a report if user owns the report' do
        user = User.find_by(username: "average joe")
        visit '/login'

        fill_in(:username, :with => "average joe")
        fill_in(:password, :with => "password123")
        click_button 'submit'

        report = Report.find_by(title: "first race")
        visit "/reports/#{report.id}"
        click_button "Delete Report"

        expect(page.status_code).to eq(200)
        expect(Report.find_by(content: "great first race. lot's of cobblestone though.")).to eq(nil)
        expect(page.current_path).to eq("/users/#{user.slug}")
      end

    end

    context 'logged out' do
      it 'does not delete a report' do
        report = Report.first
        delete "/reports/#{report.id}/delete"
        expect(last_response.location).to include("/login")
      end

    end
  end

  describe 'Edit Report Page' do
    context 'logged in' do
      it 'allows you to view edit report page' do
        user = User.find_by(username: "average joe")
        visit '/login'

        fill_in(:username, :with => "average joe")
        fill_in(:password, :with => "password123")
        click_button 'submit'

        report = Report.find_by(title: "first race")

        visit "/reports/#{report.id}/edit"

        expect(page.status_code).to eq(200)
        expect(page.body).to include(report.title)
        expect(page.body).to include(report.content)
        expect(page.body).to include(report.race.name)
      end

      it 'does not allow a user to edit a report they did not create' do
        user = User.find_by(username: "average joe")
        not_avg_joe = User.create(:username => "trackstar", :email => "ilovetorun@aol.com", :password => "shoes")
        joes_report = Report.find_by(title: "first race")

        visit '/login'

        fill_in(:username, :with => "trackstar")
        fill_in(:password, :with => "shoes")
        click_button 'submit'

        visit "/reports/#{joes_report.id}/edit"
        expect(page.current_path).to eq('/races')
      end

      it 'allows a user to edit their own report' do
        user = User.find_by(username: "average joe")
        visit '/login'

        fill_in(:username, :with => "average joe")
        fill_in(:password, :with => "password123")
        click_button 'submit'

        report = Report.find_by(title: "first race")

        visit "/reports/#{report.id}/edit"

        fill_in(:report_content, :with=> "wonderful all around")
        fill_in(:report_title, :with=> "not my first")
        fill_in(:new_race_name, :with=> "Rose Half Marathon")
        fill_in(:new_race_location, :with=> "Portland, OR")
        fill_in(:new_race_distance, :with=> "half marathon")
        fill_in(:new_race_next_race_day, :with=> "May 25th, 2018")

        click_button 'Edit Report'

        expect(page.current_path).to eq("/reports/#{report.id}")
        expect(Report.find_by(:content => "wonderful all around")).to be_instance_of(Report)
        expect(Report.find_by(:content => "great first race. lot's of cobblestone though.")).to eq(nil)
        expect(Report.find_by(:title => "not my first")).to be_instance_of(Report)
        expect(Report.find_by(:title => "first race")).to eq(nil)
        expect(page.body).to include("Rose Half Marathon")
        expect(page.status_code).to eq(200)
      end

    end

    context 'logged out' do

      it 'does not let a user edit a report' do
        report = Report.find_by(title: "first race")
        get "/reports/#{report.id}/edit"
        expect(last_response.location).to include("/login")
      end

    end
  end

  describe 'Show Report Page' do
    context 'logged in' do

      it 'allows you to see a single report of a another user' do
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
        expect(page.body).to_not include("Edit Report")
        expect(page.body).to_not include("Delete Report")

      end

      it 'allows user to see a single report with edit and delete buttons for report they wrote' do
        user = User.find_by(username: "average joe")

        visit '/login'

        fill_in(:username, :with => "average joe")
        fill_in(:password, :with => "password123")
        click_button 'submit'

        report = Report.find_by(title: "first race")
        visit "/reports/#{report.id}"

        expect(page.body).to include(report.title)
        expect(page.body).to include(report.content)
        expect(page.body).to include(report.score.to_s)
        expect(page.body).to include(report.year.to_s)
        expect(page.body).to include(report.user.username)
        expect(page.body).to include(report.race.name)
        expect(page.body).to include("Edit Report")
        expect(page.body).to include("Delete Report")

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

  describe 'Reports Index Page' do
    context 'logged in' do
      it 'allows you to see all reports' do
        user = User.create(:username => "trackstar", :email => "ilovetorun@aol.com", :password => "shoes")
        race = Race.find_by(:name => "Turkey Trot Orlando")
        report = Report.create(user: user, race: race, title: "Great times", score: 5, year: 2015, content: "All the pieces fell into place", miles_per_week: 60, runs_per_week: 5)

        visit '/login'

        fill_in(:username, :with => "trackstar")
        fill_in(:password, :with => "shoes")
        click_button 'submit'

        visit '/reports'
        expect(page.body).to include("first race")
        expect(page.body).to include("Great times")
      end
    end

    context 'logged out' do
      it 'does not allow you to view all reports' do
        get '/reports'
        expect(last_response.location).to include("/login")
      end
    end
  end

end
