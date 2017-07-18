require 'spec_helper'

describe 'Report' do
  before do
    @marathoner = User.create(username: "tester 1", email: "test@test.com", password: "test123")
    @bigsur = Race.create(name: "Big Sur International Marathon", location: "Big Sur, California", next_race_day: "April 29th, 2018", distance: "marathon")

    @report = Report.create(user: @marathoner, race: @bigsur,title: "Breathtaking views", score: 5, year: 2010, content: "My first marathon", runs_per_week: 5, miles_per_week: 45)
  end

  it 'can be initialized' do
    expect(@report).to be_an_instance_of(Report)
  end

  it 'has a title' do
    expect(@report.title).to eq("Breathtaking views")
  end

  it 'has a score' do
    expect(@report.score).to eq(5)
  end

  it 'has a year' do
    expect(@report.year).to eq(2010)
  end

  it 'has content' do
    expect(@report.content).to eq("My first marathon")
  end

  it 'has runs per week' do
    expect(@report.runs_per_week).to eq(5)
  end

  it 'has miles per week' do
    expect(@report.miles_per_week).to eq(45)
  end

  it 'has a user' do
    expect(@report.user).to eq(@marathoner)
  end

  it 'has a race' do
    expect(@report.race).to eq(@bigsur)
  end

end
