class ChaptersController < ApplicationController
  before_action :set_book
  before_action :set_chapter, only: [:show, :edit, :update, :destroy]

  def index
    @page = params["page"] || 1
    @chapters = @book.chapters.page(@page).per(10)
  end

  def new
    @chapter = Chapter.new
  end

  def create
    @chapter = Chapter.new chapter_params
    @chapter.book = @book
    if @chapter.save
      flash[:success] = 'Đã thêm chương mới'
      redirect_to book_chapters_path(@book)
    else
      render :new, errors: @chapter.errors
    end
  end

  def show
    unless @chapter.present?
      chapter_number = params[:id].to_i
      if params[:next].present?
        @chapter = @book.chapters.where(:number.gt => chapter_number).order_by({"number": "asc"}).first
        @chapter = @book.chapters.where(number: chapter_number - 1).first unless @chapter.present?
      end
      if params[:prev].present?
        @chapter = @book.chapters.where(:number.lte => chapter_number).order_by({"number": "desc"}).first
        @chapter = @book.chapters.where(number: chapter_number + 1).first unless @chapter.present?
      end
    end
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

  def destroy
    if @chapter.destroy
      flash[:danger] = 'Đã xoá chương'
      redirect_to book_chapters_path(@book)
    else
      render :new, errors: @chapter.errors
    end
  end

  private
  def chapter_params
    params.require(:chapter).permit(:name, :number, :content)
  end

  def set_book
    @book = Book.or({id: params[:book_id]}, {path: params[:book_id]}).first
    raise ActionController::RoutingError.new "Not Found." unless @book
  end

  def set_chapter
    @chapter = Chapter.or({id: params[:id]}, {number: params[:id]}).first
  end
end
