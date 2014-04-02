class AdministratorsController < ApplicationController

  #This is the administrator desktop
  def index
    @title = "Escritorio del Administrador"
    render layout: "desktop"
  end
  
  def new
    @title = "Create Administration User"
    @user = User.new()
    render layout: "administration"
  end
  
  def create
    @user = User.new(administrator_params)
    @user.name = "Administrator"
    @user.toggle!(:admin)
    if @user.save
      sign_in( @user )
      redirect_to(controller: 'generals', action: 'new')
    else
      @title = "Create Administration User"
      render 'new', layout: "administration"
    end
  end
  
  private
  
    # Never trust parameters from the scary internet, only allow the white list through.
    def administrator_params
        params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
