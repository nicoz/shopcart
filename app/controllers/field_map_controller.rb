class FieldMapController < ApplicationController
  before_action :signed_in_user
 
  before_action :is_admin
  
  def new
    @field_map = FieldMap.new(field_type_id: params[:field_type_id])
    @title = "Crear Elemento"
    
    render layout: 'desktop'
  end
  
  def create
    @field_map = FieldMap.new(field_map_params)
    if @field_map.save
      flash[:success] = "Elemento creado correctamente"
      redirect_back_or field_type_path(@field_map.field_type)
    else
      @title = "Crear Elemento"
      render 'new', layout: 'desktop'
    end
  end
  
  def edit

    @title = "Editar Elemento"
    @field_map = FieldMap.find(params[:id])

    render layout: 'desktop'
  end
  
  def update
    @field_map = FieldMap.find(params[:id])
    if @field_map.update_attributes(field_map_params)
      flash[:success] = "Elemento editado correctamente"
      redirect_back_or items_path
    else
      @title = "Editar Elemento"
      render 'edit', layout: 'desktop'
    end
  end
  
  def destroy
    @field_map = FieldMap.find(params[:id])
    if @field_map.destroy
      flash[:success] = "Elemento eliminado correctamente"
    else
      flash[:warning] = "No se pudo eliminar este Elemento"
    end
    
    redirect_back_or field_type_path(params[:field_type_id])
  end
  
  def activate
   @field_map = FieldMap.find(params[:id])
    if @field_map.activate
      flash[:success] = "Elemento activado correctamente"
    else
      flash[:warning] = "No se pudo activar este Elemento"
    end
    
    redirect_back_or field_type_path(params[:field_type_id])
  end
  
  private
    def field_map_params
      params.require(:field_map).permit(:key, :value, :field_type_id)
    end

end
