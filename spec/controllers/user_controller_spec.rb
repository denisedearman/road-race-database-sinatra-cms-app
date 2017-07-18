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
  end



end
