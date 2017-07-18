require 'spec_helper'

describe 'User' do
  before do
    @user = User.create(username: "tester 1", email: "test@test.com", password: "test123")

    nycm = Race.create(name: "New York City Marathon", location: "New York City, NY", next_race_day: "November 5th, 2017", distance: "marathon")
    bigsur = Race.create(name: "Big Sur International Marathon", location: "Big Sur, California", next_race_day: "April 29th, 2018", distance: "marathon")

    ny_report = Report.create(user: @user, race: nycm, title: "So much fun", score: 5, year: 2015, content: "I did it!", runs_per_week: 6, miles_per_week: 50.0)
    big_report = Report.create(user: @user, race: bigsur,title: "Breathtaking views", score: 5, year: 2010, content: "My first marathon", runs_per_week: 5, miles_per_week: 45)

  end

  it 'can be initialized' do
    expect(@user).to be_an_instance_of(User)
  end

  it 'has a username' do
    expect(@user.username).to eq("tester 1")
  end

  it 'has an email' do
    expect(@user.email).to eq("test@test.com")
  end

  it 'has secure password' do
    expect(@user.authenticate("notmypass")).to eq(false)
    expect(@user.authenticate("test123")).to eq(@user)
  end

  it 'has many reports' do
    expect(@user.reports.count).to eq(2)
  end

  it 'has many races' do
    expect(@user.races.count).to eq(2)
  end

  it 'can slug a username' do
    expect(@user.slug).to eq ("tester-1")
  end

  it 'can find a user by its slug' do
    slug = @user.slug
    expect(User.find_by_slug(slug).username).to eq(@user.username)
  end





end
