class PagesController < ApplicationController
  def home
  end
  
  def show
    page_name = params[:page_name]
    @static_page = StaticPage.find_by! name: page_name
    
    render layout: "static_page"
  end
end
