require 'spec_helper'

describe 'User' do
  before do
    @user = User.create(username: "tester 1", email: "test@test.com", password: "test123")
  end

  it 'has a username' do
    expect(@user.username).to eq("tester 1")
  end

  it 'can slug a username' do
    expect(@user.slug).to eq ("tester-1")
  end

  it 'can find a user by its slug' do
    slug = @user.slug
    expect(User.find_by_slug(slug).username).to eq(@user.username)
  end

  it 'has secure password' do
    expect(@user.authenticate("notmypass")).to eq(false)
    expect(@user.authenticate("test123")).to eq(@user)
  end



end
