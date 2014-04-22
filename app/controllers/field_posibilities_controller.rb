class FieldPosibilitiesController < ApplicationController
  before_action :signed_in_user
 
  before_action :is_admin
  
  def new
    @field_posibility = FieldPosibility.new(field_type_id: params[:field_type_id])
    @title = "Crear Posibilidad"
    
    render layout: 'desktop'
  end
  
  def create
    @field_posibility = FieldPosibility.new(field_posibility_params)
    if @field_posibility.save
      flash[:success] = "Posibilidad creada correctamente"
      redirect_back_or field_type_path(@field_posibility.field_type)
    else
      @title = "Crear Posibilidad"
      render 'new', layout: 'desktop'
    end
  end
  
  def edit

    @title = "Editar Posibilida"
    @field_posibility = FieldPosibility.find(params[:id])

    render layout: 'desktop'
  end
  
  def update
    @field_posibility = FieldPosibility.find(params[:id])
    if @field_posibility.update_attributes(field_posibility_params)
      flash[:success] = "Posibilidad editada correctamente"
      redirect_back_or items_path
    else
      @title = "Editar Posibilidad"
      render 'edit', layout: 'desktop'
    end
  end
  
  def destroy
    @field_posibility = FieldPosibility.find(params[:id])
    if @field_posibility.destroy
      flash[:success] = "Posibilidad eliminada correctamente"
    else
      flash[:warning] = "No se pudo eliminar esta Posibilidad"
    end
    
    redirect_back_or field_type_path(params[:field_type_id])
  end
  
  def activate
   @field_posibility = FieldPosibility.find(params[:id])
    if @field_posibility.activate
      flash[:success] = "Posibilidad activada correctamente"
    else
      flash[:warning] = "No se pudo activar esta Posibilida"
    end
    
    redirect_back_or field_type_path(params[:field_type_id])
  end
  
  private
    def field_posibility_params
      params.require(:field_posibility).permit(:text, :field_type_id)
    end

end
