require 'spec_helper'

describe ApplicationController do
  describe 'Homepage' do
    it 'loads the homepage' do
      visit '/'
      expect(page.status_code).to eq(200)
    end
  end
end
