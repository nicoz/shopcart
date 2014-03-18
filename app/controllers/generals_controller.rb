class GeneralsController < ApplicationController

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
  
  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def configuration_params
        params.require('general').permit(:name, :title, :slogan, :logo, :icon)
    end
end
