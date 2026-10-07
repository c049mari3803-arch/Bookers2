class BooksController < ApplicationController

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = Current.user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
      else
      @books = Book.all
      @user = Current.user
      render :index, status: :unprocessable_entity
    end
  end

  def index
    @books = Book.all
    @book = Book.new
    @user = Current.user
  end

  def show
    @book = Book.find(params[:id])
    @new_book = Book.new
    @user = @book.user
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user != Current.user
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book)
    else
      render :edit, status: :unprocessable_entity
    end
  end

    def destroy
      book = Book.find(params[:id])
      book.destroy
      redirect_to books_path
    end
private

  def book_params
    params.require(:book).permit(:title, :body)
  end

end
