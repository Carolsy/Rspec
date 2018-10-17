class UsersController < ApplicationController

  before_action :set_user, only: %i[edit update show]
  before_action :require_same_user, only: %i[edit update]
  before_action :require_admin, only: %i[destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "#{@user.username}さんがsignupしました！"
      redirect_to articles_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = '変更しました！'
      redirect_to articles_path
    else
      render 'edit'
    end
  end

  def show
    @user_articles = @user.articles.all
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:danger] = 'User and all articles created by user have been deleted'
    redirect_to users_path
  end

  def reset
    reset_session
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def require_same_user
    if current_user != @user
      flash[:danger] = "You can only edit your own account"
      redirect_to root_path
    end
  end

  def require_admin
    if logged_in?
      unless current_user.admin?
        flash[:danger] = "Only admin users can perform that action"
        redirect_to root_path
      else
        @user = current_user
      end
    else
      render 'sessions/new'
    end
  end
end
