class ItemsController < ApplicationController
  before_action :signed_in_user
 
  before_action :is_admin
  
  before_action :keep_location, only: [:index, :show]
  
  def index
    if !params[:name].nil? and !params[:name].empty?
      @items = Item.where(active: params[:inactive] != 'on').where("LOWER(name) like ?", "%#{params[:name].downcase}%").paginate(page: params[:page])
    else
      @items = Item.where(active: params[:inactive] != 'on').paginate(page: params[:page])
    end
    
    @items.each do |item|
      Rails.logger.info item.name
    end
    
    @title = "Administracion de Items"
    render layout: 'desktop'
  end
  
  def new
    @item = Item.new
    @title = "Crear Item"
    render layout: 'desktop'
  end
  
  def create
    @item = Item.new(items_params)
    if @item.save
      flash[:success] = "Item creado correctamente"
      redirect_back_or items_path
    else
      @title = "Crear Item"
      render 'new', layout: 'desktop'
    end
  end
  
  def edit
    @title = "Editar Item"
    @item = Item.find(params[:id])
    render layout: 'desktop'
  end
  
  def update
    @item = Item.find(params[:id])
    if @item.update_attributes(items_params)
      flash[:success] = "Item editado correctamente"
      redirect_back_or items_path
    else
      @title = "Editar Item"
      render 'edit', layout: 'desktop'
    end
  end
  
  def destroy
    @item = Item.find(params[:id])
    if @item.destroy
      flash[:success] = "Item eliminado correctamente"
    else
      flash[:warning] = "No se pudo eliminar este Item"
    end
    
    redirect_back_or items_path
  end
  
  def activate
    @item = Item.find(params[:id])
    if @item.activate
      flash[:success] = "Item activado correctamente"
    else
      flash[:warning] = "No se pudo activar este Item"
    end
    
    redirect_back_or items_path
  end
  
  def show
    @title = 'Detalles del Item'
    @item = Item.find(params[:id])
    
    @lines = @item.item_fields
    
    render layout: 'desktop'
  end
  
  private
    def items_params
      params.require(:item).permit(:name)
    end
end
