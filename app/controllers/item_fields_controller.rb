class ItemFieldsController < ApplicationController
  before_action :signed_in_user
 
  before_action :is_admin
  
  
  def new
    @item_field = ItemField.new(item_version_id: params[:item_version_id], weight: ItemField.next_weight(params[:item_version_id]))
    @title = "Crear Campo del Item"
    
    @field_types = FieldType.where(active: true)
    
    render layout: 'desktop'
  end
  
  def create
    @item_field = ItemField.new(item_field_params)
    if @item_field.save
      flash[:success] = "Campo del Item creado correctamente"
      redirect_back_or item_item_version_path(@item_field.item_version.item, @item_field.item_version)
    else
      @field_types = FieldType.where(active: true)
      @title = "Crear Campo del Item"
      render 'new', layout: 'desktop'
    end
  end
  
  def edit

    @title = "Editar Campo del Item"
    @item_field = ItemField.find(params[:id])
    @field_types = FieldType.where(active: true)
    
    render layout: 'desktop'
  end
  
  def update
    @item_field = ItemField.find(params[:id])
    if @item_field.update_attributes(item_field_params)
      flash[:success] = "Campo del Item editado correctamente"
      redirect_back_or items_path
    else
      @title = "Editar Campo del item"
      render 'edit', layout: 'desktop'
    end
  end
  
  def destroy
    @item_field = ItemField.find(params[:id])
    if @item_field.destroy
      flash[:success] = "Campo del Item eliminado correctamente"
    else
      flash[:warning] = "No se pudo eliminar este Campo del Item"
    end
    
    redirect_back_or item_item_version_path(params[:item_id], params[:item_version_id])
  end
  
  def activate
    @item_field = ItemField.find(params[:id])
    if @item_field.activate
      flash[:success] = "Campo del Item activado correctamente"
    else
      flash[:warning] = "No se pudo activar este Campo del Item"
    end
    
    redirect_back_or item_item_version_path(params[:item_id], params[:item_version_id])
  end
  
  private
    def item_field_params
      params.require(:item_field).permit(:name, :label, :item_id,
        :field_type_id, :item_version_id, :act_as, :weight, :searchable)
    end
    
    
end
