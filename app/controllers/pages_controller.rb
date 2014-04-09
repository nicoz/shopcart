class PagesController < ApplicationController
  before_action :set_configuration
  
  before_action :keep_location, only: [:home]
  
  def home
    @title = 'Inicio'
    render layout: "home"
  end
  
  def show
    page_name = params[:page_name]
    @static_page = StaticPage.find_by! name: page_name
    
    render layout: "static_page"
  end
end
