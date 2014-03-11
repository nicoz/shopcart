class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  

  def set_configuration
    @configuration = ApplicationConfiguration.take
    if @configuration.nil?
      redirect_to :start_installation
    end
  end
end
