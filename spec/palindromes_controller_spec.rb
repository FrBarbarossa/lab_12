require_relative 'spec_helper'
require_relative 'rails_helper'
require 'selenium-webdriver'

RSpec.describe PalindromesController do
  include RSpec::Expectations
  before(:each) do
    @driver = Selenium::WebDriver.for :chrome
    @base_url = 'http://localhost:3000/'
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
  end

  describe "get index page" do
    context "check index page by root" do
      it 'has code 200' do
        @driver.get @base_url
        expect(@driver.current_url).to eq('http://localhost:3000/')
        
      end
    end
  end
end

RSpec.describe PalindromesController, type: :request do
  describe "get index page" do
    context "check index page by root" do
      it 'has code 200' do
        get 'http://localhost:3000/'
        expect(response).to have_http_status(:success)
        expect(response.status).to eq(200)
      end
    end
  end
end
