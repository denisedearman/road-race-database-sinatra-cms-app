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



end
