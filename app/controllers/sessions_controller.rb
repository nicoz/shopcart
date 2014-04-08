class SessionsController < ApplicationController
  
  def new
    unless signed_in?
      @session = Session.new()
      
      @services = Service.where(active: true).where("service_type in ('Todo', 'Login')")

      @title = "Ingresar"
    end
    
    redirect_back_or root_path if signed_in?
  end
  
  
  def create
    @session = Session.new(session_params)
    user = @session.try(:save)
    if user
      flash[:success] = "Bienvenido a #{@configuration.name}"
      sign_in user
      redirect_back_or root_path
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
  
  def ajax_destroy
    sign_out
    render json: {message: 'ok'}
  end
  
  def reset
    if !signed_in?
      @title = "Olvide mi Contraseña"
      @session = Session.new()
    else
      flash[:warning] = "Esta logeado al sistema."
      redirect_to root_path
    end
  end
  
  def send_reset
    @user = User.find_by(email: params[:session][:email])
    Rails.logger.info @user.remember_token
    SessionMailer.reset_password(@user).deliver
    flash[:info] = "Se envio un email con datos para recuperar su contraseña."
    redirect_to root_path
  end
  
  def social_login
    
    @session = Session.new(session_params)
    user = @session.try(:save)
    if user
      social_sign_in user
      render json: user.to_json
    end
  end
  
  private

    def session_params
      params.require(:session).permit(:email, :password, :name, :social_id , :service_id, :social_name, :social_token)
    end
  
end
