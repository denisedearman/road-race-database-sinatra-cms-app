require 'spec_helper'

describe 'User' do
  before do
    @user = User.create(username: "tester", email: "test@test.com", password: "test123")
  end

  it 'has secure password' do
    expect(@user.authenticate("notmypass")).to eq(false)
    expect(@user.authenticate("test123")).to eq(@user)
  end



end
