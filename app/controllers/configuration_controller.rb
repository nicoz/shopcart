class ConfigurationController < ApplicationController

  def index
    @title = "System Installation"
    render layout: "administration"
  end
  
  def new_user
    @title = "Create Administration User"
    @superAdministrator = SuperAdministrator.new()
    render layout: "administration"
  end
  
  def create_user
    render layout: "administration"
    user = nil
    
    if !user.nil? and user.save()
    
    else
      render 'new_user'
    end
  end
  
  def new_configuration
    render layout: "administration"
  end
  
  def create_configuration
    render layout: "administration"
  end
end
