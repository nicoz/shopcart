class AdministratorsController < ApplicationController

  def new
    @title = "Create Administration User"
    @administrator = Administrator.new()
    render layout: "administration"
  end
  
  def create
    @administrator = Administrator.new(params['administrator'])

    if @administrator.valid?
    
    else
      @title = "Create Administration User"
      render 'new', layout: "administration"
    end
  end
end
