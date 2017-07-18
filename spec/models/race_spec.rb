require 'spec_helper'

describe 'Race' do
  before do
    @race = Race.create(name: "New York City Marathon", location: "New York City, NY", next_race_day: "November 5th, 2017", distance: "marathon")
    user = User.create(username: "tester 1", email: "test@test.com", password: "test123")
    report = Report.create(user: user, race: @race, title: "So much fun", score: 5, year: 2015, content: "I did it!", runs_per_week: 6, miles_per_week: 50.0)
  end

  it 'can be initialized' do
    expect(@race).to be_an_instance_of(Race)
  end

end
