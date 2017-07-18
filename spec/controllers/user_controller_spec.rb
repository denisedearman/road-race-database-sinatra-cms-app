require 'spec_helper'

describe UserController do

  describe "Signup Page" do
    it 'loads the signup page' do
      get '/signup'
      expect(last_response).status.to eq(200)
    end

    it 'directs the new user to races index' do
      params = {
        username: "nycrunner",
        email: "irunforlife@gmail.com",
        password: "notagoodpassword"
      }
      post '/signup', params
      expect(last_response).location.to include("/races")
    end

    it 'does not allow a user to signup without a username' do
      params = {
        username: "",
        email: "irunforlife@gmail.com",
        password: "notagoodpassword"
      }
      post '/signup', params
      expect(last_response).location.to include("/signup")
    end

    it 'does not allow a user to signup without an email' do
      params = {
        username: "nycrunner",
        email: "",
        password: "notagoodpassword"
      }
      post '/signup', params
      expect(last_response).location.to include("/signup")
    end

    it 'does not allow a user to signup without a password' do
      params = {
        username: "nycrunner",
        email: "irunforlife@gmail.com",
        password: ""
      }
      post '/signup', params
      expect(last_response).location.to include("/signup")
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
      expect(last_response).location.to include("/races")
    end


  end



end
