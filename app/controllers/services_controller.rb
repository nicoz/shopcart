class ServicesController < ApplicationController
  before_action :signed_in_user
 
  before_action :is_admin
  
  before_action :keep_location, only: [:index, :show]
  
  def index
    if !params[:name].nil? and !params[:name].empty?
      @services = Service.where(active: params[:inactive] != 'on').where("LOWER(name) like ?", "%#{params[:name].downcase}%").paginate(page: params[:page])
    else
      @services = Service.where(active: params[:inactive] != 'on').paginate(page: params[:page])
    end
    
    @title = "Administracion de Servicios"
    render layout: 'desktop'
  end
  
  def new
    @service = Service.new
    @title = "Crear servicio"
    render layout: 'desktop'
  end
  
  def create
    @service = Service.new(services_params)
    if @service.save
      flash[:success] = "Servicio creado correctamente"
      redirect_back_or services_path
    else
      @title = "Crear servicio"
      render 'new', layout: 'desktop'
    end
  end
  
  def edit
    @title = "Editar servicio"
    @service = Service.find(params[:id])
    render layout: 'desktop'
  end
  
  def update
    @service = Service.find(params[:id])
    if @service.update_attributes(services_params)
      flash[:success] = "Servicio editado correctamente"
      redirect_back_or services_path
    else
      @title = "Editar servicio"
      render 'edit', layout: 'desktop'
    end
  end
  
  def destroy
    @service = Service.find(params[:id])
    if @service.destroy
      flash[:success] = "Servicio eliminado correctamente"
    else
      flash[:warning] = "No se pudo eliminar este servicio"
    end
    
    redirect_back_or services_path
  end
  
  def activate
    @service = Service.find(params[:id])
    if @service.activate
      flash[:success] = "Servicio activado correctamente"
    else
      flash[:warning] = "No se pudo activar este servicio"
    end
    
    redirect_back_or services_path
  end
  
  def show
    @title = 'Detalles del Servicio'
    @service = Service.find(params[:id])
    
    if !params[:key].nil? and !params[:key].empty?
      @lines = ServiceInformation.where(service_id: @service.id).where(active: params[:inactive] != 'on').where("LOWER(key) like ?", "%#{params[:key].downcase}%").paginate(page: params[:page])
    else
      @lines = ServiceInformation.where(service_id: @service.id).where(active: params[:inactive] != 'on').paginate(page: params[:page])
    end
    
    render layout: 'desktop'
  end
  
  private
    def services_params
      params.require(:service).permit(:name)
    end
end
