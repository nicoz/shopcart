require 'spec_helper'

describe "Authentication" do
  before(:all) do
      General.destroy_all()
      General.create(name: "test", title: "test", slogan: "testing")
  end
    
  subject { page }

  describe "signin page" do
    before { visit signin_path }

    it { should have_content('Ingresar') }
  end
  
  describe "signin" do
    before { visit signin_path }

    describe "with invalid information" do
      before { click_button "Ingresar a la tienda" }

      it { should have_content('Ingresar') }
      it { should have_selector('div.alert.alert-warning') }
      
      describe "after visiting another page" do
        before { click_link "Inicio" }
        it { should_not have_selector('div.alert.alert-warning') }
      end
    end
    
    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      
      before do
        fill_in "session_email",    with: user.email.upcase
        fill_in "session_password", with: user.password
        click_button "Ingresar a la tienda"
      end

      it { should have_link("Inicio",     href: root_path) }
      it { should have_link('Cerrar Sesión',    href: signout_path) }
      it { should_not have_link('Ingresar', href: signin_path) }
      
      describe "followed by signout" do
        before { click_link "Cerrar Sesión" }
        it { should have_link('Ingresar') }
      end
    end
  end
end
