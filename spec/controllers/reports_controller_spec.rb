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

  descibe "Create Report Page" do
    it 'allows you to view a form to create a new report' do
      visit '/reports/new'
      expect(page.body).to include('<form')
      expect(page.body).to include('report[title]')
      expect(page.body).to include('report[score]')
      expect(page.body).to include('report[year]')
      expect(page.body).to include('report[content]')
      expect(page.body).to include('report[runs_per_week]')
      expect(page.body).to include('report[miles_per_week]')
      expect(page.body).to include('race[name]')
    end



    end
  end

end
