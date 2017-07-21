require 'spec_helper'

describe ApplicationController do
  describe 'Homepage' do
    context 'logged in' do
      it 'redirects to the races index' do
        user = User.create(:username => "trackstar", :email => "ilovetorun@aol.com", :password => "shoes")

        visit '/login'

        fill_in(:username, :with => "trackstar")
        fill_in(:password, :with => "shoes")
        click_button 'submit'

        visit '/'

        expect(page.current_path).to include('/races')
      end
    end

    context 'logged out' do
      it 'loads the homepage' do
        visit '/'
        expect(page.status_code).to eq(200)
      end
    end
  end
end
