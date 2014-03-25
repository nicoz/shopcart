class SessionsController < ApplicationController
  
  def new
    @session = Session.new()
    @title = "Ingresar"
  end
  
  
  def create
    @session = Session.new(session_params)
    if @session.save
      flash[:success] = "Bienvenido a #{@configuration.name}"
      redirect_to root_path
    else
      @title = "Ingresar"
      render 'new'
    end
  end

  private

    def session_params
      params.require(:session).permit(:email, :password)
    end
  
end
