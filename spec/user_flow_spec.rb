require_relative 'spec_helper'
require_relative 'rails_helper'
require 'selenium-webdriver'


RSpec.describe "User is not logged in",:js => true, :type => :system do
    before do
      driven_by(:selenium_chrome_headless)
      Capybara.default_max_wait_time = 5
    end
  
    let (:output) {[1, 2, 3, 11, 22]}
    
    it "there is no selector 'number'" do
      visit "/"
      expect(page).to have_no_selector("table tr td")
    end

    it "there is selectors of login and register" do
        visit "/"
        expect(page).to have_button('Зарегистрироваться')
        expect(page).to have_button("Войти")
    end
    

    context "user register in" do
      it "allows to make calculations" do
        visit "/register"
        fill_in "login", with: "TestTest"
        fill_in "password", with: "Testpassw"
        fill_in "password_confirmation", with: "Testpassw"
        click_button "Зарегистрироваться"

        expect(page).to have_button("Найти")
        expect(page.current_path).to eq ('/')
        fill_in "number", with: "100"
        click_button ("Найти")
        # expect(page).to have_selector("table tr td")
        all("table tr td").each_with_index{|val, ind| if (ind - 1) % 3 == 0 then expect(val).to have_text(output[(ind-1)/3]) end}
      end
    end

  end

  # Тест невозможности вычислений без ввода логина/пароля
  RSpec.describe PalindromesController, type: :request do
    describe "get result page" do
      context "user unlogged" do
        it 'returns alert' do
          get 'http://localhost:3000/result?number=10'
          expect(response).to redirect_to("/")
          follow_redirect!
          expect(response.body).to include('alert alert-info')
        end
      end
    end
  end