class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.password == params[:session][:password]
      session[:user_id] = user.id
      flash[:success] = "#{user.username}登録しました！"
      redirect_to root_path
    else
      flash.now[:danger] = 'password or emailを入力し間違えました！'
      render 'new'
    end

  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'logged out!'
    redirect_to root_path
  end
end
