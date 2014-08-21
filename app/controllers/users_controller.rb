class UsersController < ApplicationController

  def index
    @users = User.order(:email).all
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = "success! new user has been created"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      flash[:success] = "success! user has been updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    flash[:success] = "success! user has been deleted"
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :contact, :email, :rate)
  end

end