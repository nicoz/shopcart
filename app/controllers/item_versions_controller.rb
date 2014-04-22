class ItemVersionsController < ApplicationController
  before_action :signed_in_user
  
  before_action :is_admin
  
  before_action :keep_location, only: [:show]
  
  def show
    @item_version = ItemVersion.find(params[:id])
    @title = 'Detalles de la Version'
    
    @lines = @item_version.lines(params).paginate(page: params[:page])
    
    render layout: 'desktop'
  end
  
  def create
   
    item = Item.find(params[:item_id])
    if ItemVersion.create(item_id: item.id)
      flash[:success] = "Version creada correctamente"
    else
      flash[:warning] = "No se pudo crear la Version"
    end
    
    
    redirect_to item_path(item)

  end

  def destroy
    @item_version = ItemVersion.find(params[:id])
    if @item_version.destroy
      flash[:success] = "Version cancelada correctamente"
    else
      flash[:warning] = "No se pudo cancelar esta Version"
    end
    
    redirect_back_or item_path(params[:item_id])
  end
  
  def close
    @item_version = ItemVersion.find(params[:id])
    if @item_version.close
      flash[:success] = "Version cerrada correctamente"
    else
      flash[:warning] = "No se pudo cerrar esta Version"
    end
    
    redirect_back_or item_path(params[:item_id])
  end
end
