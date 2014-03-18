class AdministratorsController < ApplicationController

  def new
    @title = "Create Administration User"
    @administrator = Administrator.new()
    render layout: "administration"
  end
  
  def create
    @administrator = Administrator.new(administrator_params)

    if @administrator.valid?
      redirect_to(controller: 'generals', action: 'new')
    else
      @title = "Create Administration User"
      render 'new', layout: "administration"
    end
  end
  
  private
  
    # Never trust parameters from the scary internet, only allow the white list through.
    def administrator_params
        params.require(:administrator).permit(:email, :password, :confirmation)
    end
end
