class ServiceInformationController  < ApplicationController
  before_action :signed_in_user
 
  before_action :is_admin
  
  
  def new
    @serviceInformation = ServiceInformation.new(service_id: params[:service_id])
    @title = "Crear valor del servicio"
    render layout: 'desktop'
  end
  
  def create
    Rails.logger.info '--------------------------------------------------------'
    Rails.logger.info '--------------------------------------------------------'
    Rails.logger.info 'SERVICE INFORMATION CREATE'
    Rails.logger.info params
    Rails.logger.info service_information_params
    @serviceInformation = ServiceInformation.new(service_information_params)
    if @serviceInformation.save
      flash[:success] = "Valor del servicio creado correctamente"
      redirect_back_or services_path
    else
      @title = "Crear valor del servicio"
      render 'new', layout: 'desktop'
    end
  end
  
  def edit
    Rails.logger.info '--------------------------------------------------------'
    Rails.logger.info '--------------------------------------------------------'
    Rails.logger.info 'SERVICE INFORMATION EDIT'
    Rails.logger.info params
    @title = "Editar servicio"
    @serviceInformation = ServiceInformation.find(params[:id])
    render layout: 'desktop'
  end
  
  def update
    @serviceInformation = ServiceInformation.find(params[:id])
    if @serviceInformation.update_attributes(service_information_params)
      flash[:success] = "Servicio editado correctamente"
      redirect_back_or services_path
    else
      @title = "Editar servicio"
      render 'edit', layout: 'desktop'
    end
  end
  
  def destroy
    @serviceInformation = ServiceInformation.find(params[:id])
    if @serviceInformation.destroy
      flash[:success] = "Valor eliminado correctamente"
    else
      flash[:warning] = "No se pudo eliminar este valor"
    end
    
    redirect_back_or service_path(params[:service_id])
  end
  
  def activate
    @serviceInformation = ServiceInformation.find(params[:id])
    if @serviceInformation.activate
      flash[:success] = "Valor activado correctamente"
    else
      flash[:warning] = "No se pudo activar este valor"
    end
    
    redirect_back_or service_path(params[:service_id])
  end
  
  private
    def service_information_params
      params.require(:service_information).permit(:key, :value, :service_id)
    end
    
    
end
