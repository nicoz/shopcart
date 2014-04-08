class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  
  before_filter :load_configuration

  def set_configuration
    if @configuration.nil?
      redirect_to :start_installation
    end
  end
  
  def back
    redirect_back_or root_path
  end
  
  # Before filters
  def keep_location
    store_location
  end

  def signed_in_user
    Rails.logger.info '---------------------------------------------------------'
    Rails.logger.info '---------------------------------------------------------'
    Rails.logger.info "Signed in User filter"
    unless signed_in?
      store_location
      redirect_to signin_path, notice: "Por favor ingrese al sistema"
    end
  end
  
  def correct_user
    Rails.logger.info '---------------------------------------------------------'
    Rails.logger.info '---------------------------------------------------------'
    Rails.logger.info "Correct User filter"
    @user = User.find(params[:id])
    unless current_user?(@user)
      flash[:notice] = "Esta intentado acceder a informacion privada de otro usuario"
      redirect_back_or root_path
    end
  end
  
  def is_admin
    Rails.logger.info '---------------------------------------------------------'
    Rails.logger.info '---------------------------------------------------------'
    Rails.logger.info "Is admin filter"
    Rails.logger.info "#{current_user.is_admin?}"
    redirect_back_or root_path, 
      notice: "Esta intentado acceder a una seccion privada del sistema" unless current_user.is_admin?
  end
  
  private 
    def load_configuration
      @configuration = General.take
    end
end
