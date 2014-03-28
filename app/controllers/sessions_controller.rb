class SessionsController < ApplicationController
  
  def new
    @session = Session.new()
    @title = "Ingresar"
  end
  
  
  def create
    @session = Session.new(session_params)
    user = @session.save
    if user
      flash[:success] = "Bienvenido a #{@configuration.name}"
      sign_in user
      redirect_to root_path
    else
      flash.now[:warning] = "Email y/o contraseña incorrecta."
      @title = "Ingresar"
      render 'new'
    end
  end
  
  def destroy
    sign_out
    redirect_to root_path
  end
  

  private

    def session_params
      params.require(:session).permit(:email, :password)
    end
  
end
