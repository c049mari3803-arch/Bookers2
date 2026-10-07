class UsersController < ApplicationController
# 認証をスキップ: サインアップ（new, create）はログイン前に行うため
  allow_unauthenticated_access only: [:new, :create] 
 
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
    unless @user == Current.user
      redirect_to user_path(Current.user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'You have updated user successfully.'
    else
      render :edit, status: :unprocessable_entity
    end
  end
 
  def create
    @user = User.new(user_params)
    if @user.save
      start_new_session_for @user
      session[:user_id] = @user.id
      
      # ユーザー登録成功後、ユーザー詳細ページ（マイページ）へリダイレクト
      redirect_to user_path(@user), notice: "Welcome! You have signed up successfully."
    else
      # エラー時はフォームを再表示
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @users = User.all
    @user = Current.user
    @book = Book.new
  end
 
  private
 
  def user_params
    params.require(:user).permit(:name, :email_address, :password, :password_confirmation, :introduction, :profile_image)
  end
end