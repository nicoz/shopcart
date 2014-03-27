require 'spec_helper'
require 'erb'

describe "Pages" do
  describe "Installation" do
    describe "Start installation" do
      it "should redirect to installation page if there is no configuration" do
        General.destroy_all()
        visit "/"
        current_path.should == start_installation_path
        expect(page).to have_title("Imaginatio Shopcart - System Installation")
      end
      
      it "should proceed to user creation after clicking 'Get started'" do
        General.destroy_all()
        visit "/"
        find(:xpath, "//a[@href='/installation/user/new']").click
        expect(page).to have_title("Imaginatio Shopcart - Create Administration User")
      end
    end
    
    describe "Create administration user page" do
      it "should ask for User email, password and password confirmation" do
        visit "/installation/user/new"
        expect(page).to have_selector("input#administrator_email")
        expect(page).to have_selector("input#administrator_password")
        expect(page).to have_selector("input#administrator_confirmation")
      end
    end
  end
  
  
  describe "Static Pages" do
    before(:all) do
      General.destroy_all()
      General.create(name: "test", title: "test", slogan: "testing")
    end
    
    it "should have the content 'Registrese como usuario'" do
      visit "/"
      expect(page).to have_content("Registrese como usuario")
    end
    
    it "should show the content of the page" do
      static_page = StaticPage.create(name: "contact_us", title: "Contact Us", content: "<h1>formulario<%= 2 + 2 %></h1>")
      visit "/#{static_page.name}"
      expect(page).to have_selector('body', ERB.new(static_page.content).result.to_s.html_safe)
    end
    
    it "should show 404 page when the page does not exists" do
      visit "/nonexistingpage"
      expect(page).to have_title("Page not found")
      expect(page.status_code).to eq(404)
    end
  end
end
