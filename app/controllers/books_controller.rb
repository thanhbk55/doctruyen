class BooksController < ApplicationController
  before_action :set_book, only: [:edit, :update]

  def index
    @books = Book.all
  end

  def edit
  end

  def update
    if @book.update book_params
      flash[:success] = 'Cập nhật thành công'
      redirect_to edit_book_path(@book)
    else
      render :edit, errors: @chapter.errors
    end
  end

  def new
    @book = Book.new
  end

  private
  def book_params
    params.require(:book).permit(:name)
  end

  def set_book
    @book = Book.or({id: params[:id]}, {path: params[:id]}).first
    raise ActionController::RoutingError.new "Not Found." unless @book
  end
end
