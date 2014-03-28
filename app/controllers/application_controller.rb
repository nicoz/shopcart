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
  
  private 
    def load_configuration
      @configuration = General.take
    end
end
