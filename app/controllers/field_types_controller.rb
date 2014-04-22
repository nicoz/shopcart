class FieldTypesController < ApplicationController
  before_action :signed_in_user
 
  before_action :is_admin
  
  before_action :keep_location, only: [:index, :show]
  
  def index
    if !params[:name].nil? and !params[:name].empty?
      @field_types = FieldType.where(active: params[:inactive] != 'on').where("LOWER(name) like ?", "%#{params[:name].downcase}%").paginate(page: params[:page])
    else
      @field_types = FieldType.where(active: params[:inactive] != 'on').paginate(page: params[:page])
    end
    
    @field_types.each do |field_type|
      Rails.logger.info field_type.name
    end
    
    @title = "Administracion de Tipos de campo"
    render layout: 'desktop'
  end
  
  def new
    @field_type = FieldType.new
    @title = "Crear Tipo de campo"
    render layout: 'desktop'
  end
  
  def create
    @field_type = FieldType.new(field_types_params)
    if @field_type.save
      flash[:success] = "Tipo de campo creado correctamente"
      redirect_back_or field_types_path
    else
      @title = "Crear Tipo de campo"
      render 'new', layout: 'desktop'
    end
  end
  
  def edit
    @title = "Editar Tipo de campo"
    @field_type = FieldType.find(params[:id])
    render layout: 'desktop'
  end
  
  def update
    @field_type = FieldType.find(params[:id])
    if @field_type.update_attributes(field_types_params)
      flash[:success] = "Tipo de campo editado correctamente"
      redirect_back_or field_types_path
    else
      @title = "Editar FieldType"
      render 'edit', layout: 'desktop'
    end
  end
  
  def destroy
    @field_type = FieldType.find(params[:id])
    if @field_type.destroy
      flash[:success] = "Tipo de campo eliminado correctamente"
    else
      flash[:warning] = "No se pudo eliminar este Tipo de campo"
    end
    
    redirect_back_or field_types_path
  end
  
  def activate
    @field_type = FieldType.find(params[:id])
    if @field_type.activate
      flash[:success] = "Tipo de campo activado correctamente"
    else
      flash[:warning] = "No se pudo activar este Tipo de campo"
    end
    
    redirect_back_or field_types_path
  end
  
  def show
    @title = 'Detalles del Tipo de campo'
    @field_type = FieldType.find(params[:id])
    
    @lines = @field_type.lines(params).paginate(page: params[:page])

    render layout: 'desktop'
  end
  
  private
    def field_types_params
      params.require(:field_type).permit(:name, :field_type)
    end
end
