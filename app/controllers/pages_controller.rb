class PagesController < ApplicationController
  before_action :set_configuration
  
  before_action :keep_location, only: [:home]
  
  def home
    @title = 'Inicio'
    
    @book = Item.where(name: 'Libro').first
    @books = ItemInstance.joins(item_version: :item).where('items.active=?', true).where('items.id=?', @book.id).where(active: true)
    
    render layout: "home"
  end
  
  def show
    page_name = params[:page_name]
    @static_page = StaticPage.find_by! name: page_name
    
    render layout: false
  end
end
