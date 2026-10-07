class SessionsController < ApplicationController

  allow_unauthenticated_access only: [:new, :create]

  def new

  end

  def create
    user = User.find_by(name: params[:name])

    if user && user.authenticate(params[:password])
      # ログイン成功時：セッションにユーザーIDを保存
      start_new_session_for user
      redirect_to after_authentication_url, notice: "Signed in successfully."
    else
      # ログイン失敗時：エラーを出してログイン画面を再表示
      flash.now[:alert] = "Invalid name or password."
#      render :new, status: :unprocessable_entity
      redirect_to new_session_path
    end
  end

  def destroy
    terminate_session
    
    redirect_to root_path, notice: "Signed out successfully."
  end
end
