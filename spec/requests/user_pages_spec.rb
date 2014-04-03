require 'spec_helper'
include ApplicationHelper

describe "User pages" do

  subject { page }

  describe "signup page" do
    before { visit signup_path }

    it { should have_content('Registrarse') }
  end
  
  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      visit signin_path
      fill_in "session_email", with: user.email
      fill_in "session_password", with: user.password
      click_button "Ingresar a la tienda"
      visit user_path(user)
    end

    #it { should have_content("#{user.name}, #{user.email}") }
    it { should have_title(full_title(user.name)) }
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
      
      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by(email: 'user@example.com') }

        it { should have_link('Cerrar Sesión') }
        it { should have_selector('div.alert.alert-success', text: "Bienvenido a test") }
      end
    end
  end
end
