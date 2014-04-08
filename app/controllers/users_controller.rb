class UsersController < ApplicationController
  before_action :signed_in_user, only: [:show, :index, :edit, :update, :edit_password, :reset, :profile]
    
  before_action :correct_user,   only: [:edit, :update]
  
  before_action :is_admin, only: [:index]
  
  before_action :keep_location, only: [:index, :show]
  
  def index
    Rails.logger.info '--------------------------------------------------------'
    Rails.logger.info '--------------------------------------------------------'
    Rails.logger.info 'User index'
    Rails.logger.info params[:inactive] != 'on'
    if !params[:name].nil? and !params[:name].empty?
      @users = User.where(active: params[:inactive] != 'on').where("LOWER(name) like ?", "%#{params[:name].downcase}%").paginate(page: params[:page])
    else
      @users = User.where(active: params[:inactive] != 'on').paginate(page: params[:page])
    end
    
    @title = "Administracion de Usuarios"
    render layout: 'desktop'
  end
  
  def new
    @user = User.new()
    @title = "Registrarse"
  end
  
  
  def show
    @user = User.find(params[:id])
    @title = @user.name
    render layout: 'desktop'
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Bienvenido a #{@configuration.name}"
      redirect_to root_path
    else
      @title = "Registrarse"
      render 'new'
    end
  end
  
  def edit
    @title = "Editar datos del usuario"
    @user = User.find(params[:id])
    @user.updating_data = true
  end
  
  def edit_password
    @title = "Cambiar Contraseña"
    @user = current_user
  end
  
  def reset
    @user = User.find(params[:id])
    @user.updating_password = true
    if @user.update_attributes(user_params)
      flash[:success] = "Contraseña editada correctamente"
      redirect_back_or profile_path
    else
      render 'edit_password'
    end
  end
  
  def update
    @user = User.find(params[:id])
    @user.updating_data = true
    if @user.update_attributes(user_params)
      flash[:success] = "Datos del usuario modificados correctamente"
      redirect_back_or profile_path
    else
      render 'edit'
    end
  end

  def profile
    @user = current_user
    @title = @user.name
  end
  
  def password_recovery
    @title = "Recuperacion de Contraseña"
    @user = User.find_by(remember_token: params[:remember_token])
  end
  
  def set_recovery_password
    @user = User.find(params[:id])
    @user.reseting_password = true
    if @user.update_attributes(user_params)
      flash[:success] = "Contraseña creada correctamente"
      redirect_to root_path
    else
      render 'password_recovery'
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:success] = "Usuario eliminado correctamente"
    else
      flash[:warning] = "No se pudo eliminar este usuario"
    end
    
    redirect_back_or users_path
  end
  
  def activate
    @user = User.find(params[:id])
    if @user.activate
      flash[:success] = "Usuario activado correctamente"
    else
      flash[:warning] = "No se pudo activar este usuario"
    end
    
    redirect_back_or users_path
  end
  
  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation, :old_password, :avatar)
    end
    
    

end
