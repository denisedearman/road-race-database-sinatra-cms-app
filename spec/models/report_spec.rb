require 'spec_helper'

describe 'Report' do
  before do
    marathoner = User.create(username: "tester 1", email: "test@test.com", password: "test123")
    bigsur = Race.create(name: "Big Sur International Marathon", location: "Big Sur, California", next_race_day: "April 29th, 2018", distance: "marathon")

    @report = Report.create(user: marathoner, race: bigsur,title: "Breathtaking views", score: 5, year: 2010, content: "My first marathon", runs_per_week: 5, miles_per_week: 45)
  end
end
