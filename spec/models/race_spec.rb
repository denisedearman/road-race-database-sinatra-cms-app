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

  it 'has a name' do
    expect(@race.name).to eq("New York City Marathon")
  end

  it 'has a location' do
    expect(@race.location).to eq("New York City, NY")
  end

  it 'has a next race day' do
    expect(@race.next_race_day).to eq("November 5th, 2017")
  end

  it 'has a distance' do
    expect(@race.distance).to eq("marathon")
  end

  it 'has many reports' do
    expect(@race.reports.count).to eq(1)
  end

  it 'has many users' do
    expect(@race.users.count).to eq(1)
  end

  it 'can slugify its name' do
    expect(@race.slug).to eq("new-york-city-marathon")
  end

  it 'can find a race by its slug' do
    slug = @race.slug
    expect(Race.find_by_slug(slug).name).to eq("New York City Marathon")
  end
end
