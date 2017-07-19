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
    it 'allows you to view a form to create a new report' do
      visit '/reports/new'
      expect(page.body).to include('<form')
      expect(page.body).to include('report[title]')
      expect(page.body).to include('report[score]')
      expect(page.body).to include('report[year]')
      expect(page.body).to include('report[content]')
      expect(page.body).to include('report[runs_per_week]')
      expect(page.body).to include('report[miles_per_week]')
      expect(page.body).to include('report[race_ids][]')
      expect(page.body).to include('race[name]')
      expect(page.body).to include('race[location]')
      expect(page.body).to include('race[next_race_day]')
      expect(page.body).to include('race[distance]')
    end

    it 'allows you to create a report with a race' do
      visit '/reports/new'
      fill_in :report_title, with: "Best Race Ever"
      fill_in :report_score, with: 5
      fill_in :report_year, with: 2015
      fill_in :report_content, with: "The BEST RACE EVER"
      fill_in :report_runs_per_week, with: 5
      fill_in :report_miles_per_week, with: 35
      check "none"
      fill_in :new_race_title, with: "Santa Claus 5k"
      fill_in :new_race_location, with: "Tampa, FL"
      fill_in :new_race_next_race_day, with: "December 25th, 2017"
      fill_in :distance, with: "5k"
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
      expect(report.race).to eq(Race.first)
    end



    it 'allows you to create a report with a new race' do
      visit '/reports/new'
      fill_in :report_title, with: "Best Race Ever"
      fill_in :report_score, with: 5
      fill_in :report_year, with: 2015
      fill_in :report_content, with: "The BEST RACE EVER"
      fill_in :report_runs_per_week, with: 5
      fill_in :report_miles_per_week, with: 35
      check "race_#{Race.first.id}"
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
  end

end
