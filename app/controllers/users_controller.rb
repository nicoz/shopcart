class UsersController < ApplicationController
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
      # Handle a successful save.
    else
      @title = "Registrarse"
      render 'new'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end
