class ChaptersController < ApplicationController
  before_action :set_book
  before_action :set_chapter, only: [:show, :edit, :update]

  def index
    @chapters = @book.chapters
  end

  def show
  end

  def edit
  end

  def update
    if @chapter.update chapter_params
      flash[:success] = 'Cập nhật thành công'
      redirect_to edit_book_chapter_path(@book, @chapter)
    else
      render :edit, errors: @chapter.errors
    end
  end

  private
  def chapter_params
    params.require(:chapter).permit(:name, :number, :content)
  end

  def set_book
    @book = Book.where(id: params[:book_id]).first
    raise ActionController::RoutingError.new "Not Found." unless @book
  end

  def set_chapter
    @chapter = Chapter.where(id: params[:id]).first
    raise ActionController::RoutingError.new "Not Found." unless @chapter
  end
end
