require 'spec_helper'
require 'erb'

describe "Pages" do
  describe "Home Page" do
    it "should have the content 'Home Page'" do
      visit "/pages/home"
      expect(page).to have_content("Home Page")
    end
  end
  
  describe "Root" do
    it "should have the same content as Home Page" do
      visit "/"
      expect(page).to have_content("Home Page")
    end
  end
  
  describe "Static Pages" do
    it "should show the content of the page" do
      static_page = StaticPage.create(name: "contact_us", title: "Contact Us", content: "<h1>formulario<%= 2 + 2 %></h1>")
      visit "/#{static_page.name}"
      expect(page).to have_selector('body', ERB.new(static_page.content).result.to_s.html_safe)
    end
  end
end
