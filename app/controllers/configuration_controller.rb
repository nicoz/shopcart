class ConfigurationController < ApplicationController

  def index
    @title = "System Installation"
    render layout: "administration"
  end
  
  
  def new
    render layout: "administration"
  end
  
  def create
    render layout: "administration"
  end
end
