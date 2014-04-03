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
  
  describe "authorization" do

    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }

      describe "in the Users controller" do

        describe "visiting the edit page" do
          before { visit edit_user_path(user) }
          it { should have_title( full_title('Ingresar') ) }
        end

        describe "submitting to the update action" do
          before { patch user_path(user) }
          specify { expect(response).to redirect_to(signin_path) }
        end
        
        describe "visiting the password edit page" do
          before { visit edit_password_path}
          it { should have_title( full_title('Ingresar') ) }
        end

        describe "submitting to the password update action" do
          before { patch reset_password_path(user) }
          specify { expect(response).to redirect_to(signin_path) }
        end
        

        describe "when attempting to visit a protected page" do
          before do
            visit edit_user_path(user)
            fill_in "session_email",    with: user.email
            fill_in "session_password", with: user.password
            click_button "Ingresar a la tienda"
          end

          describe "after signing in" do

            it "should render the desired protected page" do
              expect(page).to have_title( full_title('Editar datos del usuario') )
            end
          end
        end
      end
    end
  end
end
