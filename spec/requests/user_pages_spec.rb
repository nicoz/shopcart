require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "signup page" do
    before { visit signup_path }

    it { should have_content('Registrarse') }
  end
  
  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    #it { should have_content("#{user.name}, #{user.email}") }
    it { should have_title(user.name) }
  end
  
  describe "signup" do
    before { visit signup_path }

    let(:submit) { "Crear mi cuenta" }
    
    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end
    
    describe "with valid information" do
      before do
        fill_in "user_name",         with: "Example User"
        fill_in "user_email",        with: "user@example.com"
        fill_in "user_password",     with: "Nicolas1"
        fill_in "user_password_confirmation", with: "Nicolas1"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end
  end
end