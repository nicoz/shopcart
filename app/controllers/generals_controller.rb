class GeneralsController < ApplicationController
  before_action :signed_in_user, only: [:show, :index, :edit, :update, :edit_password, :reset, :profile]
    
  before_action :is_admin, only: [:show, :edit, :update]
  
  before_action :keep_location, only: [:show]
  
  def index
    @title = "System Installation"
    render layout: "administration"
  end
  
  
  def new
    @title = "Create System Configuration"
    @general = General.new()
    render layout: "administration"
  end
  
  def create
    @general = General.new(configuration_params)
    if @general.save()
      redirect_to root_path
    else
      @title = "Create System Configuration"
      render 'new', layout: "administration"
    end
  end
  
  def show
    @title = "Configuracion del sistema"
    @general = General.take
    
    render layout: 'desktop'
  end
  
  def edit
    @title = "Editar la configuracion del sistema"
    @general = General.take
  end
  
  def update
    @general = General.find(params[:id])
    if @general.update_attributes(configuration_params)
      flash[:success] = "Configuracion modificada correctamente"
      redirect_back_or profile_path
    else
      render 'edit'
    end 
  end
  
  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def configuration_params
        params.require('general').permit(:name, :title, :slogan, :logo, :icon)
    end
end
