class UsersController < ApplicationController
  before_action :signed_in_user, only: [:show, :index, :edit, :update, :edit_password, :reset, :profile]
    
  before_action :correct_user,   only: [:show, :edit, :update]
  
  before_action :is_admin, only: [:index]
  
  before_action :keep_location, only: [:index, :show]
  
  def index
    @users = User.paginate(page: params[:page])
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
    render 'show'
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
  
  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation, :old_password, :avatar)
    end
    
    

end
