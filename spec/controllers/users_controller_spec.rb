require 'spec_helper'

describe UsersController do
  before do
    shalane = User.create(username: "shalane", email: "shalane@olympians.net", password: "trackqueen")
  end

  after do
    User.destroy_all
  end

  describe "Signup Page" do
    it 'loads the signup page' do
      get '/signup'
      expect(last_response.status).to eq(200)
    end

    it 'allows you to view form to create a user' do
      visit '/signup'
      expect(page.body).to include('<form')
      expect(page.body).to include('username')
      expect(page.body).to include('email')
      expect(page.body).to include('password')
    end

    it 'allows you to create a new user' do
      visit '/signup'
      fill_in :username, :with => "bolt"
      fill_in :email, :with => "fasterthanyou@nike.com"
      fill_in :password, :with => "gold"
      click_button "Sign Up"
      expect(User.all.count).to eq(2)
    end

    it 'directs the new user to races index' do
      params = {
        username: "nycrunner",
        email: "irunforlife@gmail.com",
        password: "notagoodpassword"
      }
      post '/signup', params
      expect(last_response.location).to include("/races")
    end

    it 'does not allow a user to signup without a username' do
      params = {
        username: "",
        email: "irunforlife@gmail.com",
        password: "notagoodpassword"
      }
      post '/signup', params
      expect(last_response.location).to include("/signup")
    end

    it 'does not allow a user to signup without an email' do
      params = {
        username: "nycrunner",
        email: "",
        password: "notagoodpassword"
      }
      post '/signup', params
      expect(last_response.location).to include("/signup")
    end

    it 'does not allow a user to signup without a password' do
      params = {
        username: "nycrunner",
        email: "irunforlife@gmail.com",
        password: ""
      }
      post '/signup', params
      expect(last_response.location).to include("/signup")
    end

    it 'does not allow a logged in user to view the signup page' do
      user = User.create(username: "nycrunner", email: "irunforlife@gmail.com", password: "notagoodpassword")
      params = {
        username: "nycrunner",
        email: "irunforlife@gmail.com",
        password: "notagoodpassword"
      }
      post '/signup', params
      session = {}
      session[:user_id] = user.id
      get '/signup'
      expect(last_response.location).to include("/races")
    end
  end

  describe "Login Page" do

    it 'loads the login page' do
      get '/login'
      expect(last_response.status).to eq(200)
    end

    it 'loads the races index after login' do
      user = User.create(username: "scott", email: "ultra@gmail.com", password: "runningformiles")
      visit '/login'

      fill_in(:username, :with => "scott")
      fill_in(:password, :with => "runningformiles")

      click_button 'submit'
      expect(page.current_path).to eq('/races')
    end

    it 'does not let the user view login page if already logged in' do
      user = User.create(username: "scott", email: "ultra@gmail.com", password: "runningformiles")
      params = {
        username: "scott",
        password: "runningformiles"
      }
      post '/login', params
      session = {}
      session[:user_id] = user.id
      get '/login'
      expect(last_response.location).to include("/races")
    end

  end

  describe "Logout" do

    it 'lets a user logout if already logged in' do
      user = User.create(username: "scott", email: "ultra@gmail.com", password: "runningformiles")
      params = {
        username: "scott",
        password: "runningformiles"
      }
      post '/login', params
      get '/logout'
      expect(last_response.location).to include("/login")
    end

    it 'does not allow a user to logout if not logged in' do
      get '/logout'
      expect(last_response.location).to include("/")
    end

    it 'does not load /races if user is not logged in' do
      get '/races'
      expect(last_response.location).to include("/login")
    end

    it 'does load /races if user is logged in' do
      user = User.create(username: "scott", email: "ultra@gmail.com", password: "runningformiles")
      params = {
        username: "scott",
        password: "runningformiles"
      }
      post '/login', params
      get '/races'
      expect(last_response.status).to eq(200)
    end

  end

  describe 'User Show Page' do
    it 'shows all single users reports'  do
      user = User.create(username: "scott", email: "ultra@gmail.com", password: "runningformiles")

      queens_ten = Race.create(name: "Queens 10k", location: "Queens, NY", next_race_day: "June 10th, 2018", distance: "10k")
      badwater = Race.create(name: "Badwater 135", location: "Badwater Basin, CA", next_race_day: "July 10th, 2017", distance: "135 miles")

      ten_k_report = Report.create(user: user, race: queens_ten, title: "good race", score: 4, year: 2015, content: "good race overall.", runs_per_week: 10, miles_per_week: 80)
      badwater_win = Report.create(user: user, race: badwater, title: "Win", score: 2, year: 2007, content: "it's the toughest footrace for a reason", runs_per_week: 15, miles_per_week: 125)

      get "/users/#{user.slug}"

      expect(last_response.body).to include("Win")
    end
  end



end
