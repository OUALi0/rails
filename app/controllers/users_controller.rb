class UsersController < ApplicationController
    def new
      @user = User.new
    end
    def show
      @user = User.find(params[:id])
    end
    def create
      @user = User.new(user_params)
      if @user.save
        session[:user_id] = @user.id
        redirect_to root_path, notice: "Bienvenue sur le site!"
      else
        render :new
      end
    end
    def destroy
      session[:user_id] = nil
      redirect_to signin_path, notice: "Vous êtes déconnecté!"
    end
    def signin
    end
    
    def login
      @user = User.find_by(email: params[:email])
      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id 
        redirect_to root_path, notice: "Vous êtes connecté!"
      else
        flash.now[:alert] = "Email ou mot de passe invalide!"
        render :signin
      end
    end
    private
    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
  end
  