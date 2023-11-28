class BooksController < ApplicationController
  
  before_action :is_matching_login_user, only: [:edit, :update]
  
  def index
     @books=Book.all
    @book=Book.new
    @user=current_user
  end

  def create
    @book = Book.new(book_params)
   @book.user_id = current_user.id
   if  @book.save
       flash[:notice]= "You have created book successfully."
    redirect_to book_path(@book.id)
     else
       @books=Book.all
        @user=current_user
      render :index
  end
end

  def show
     @book=Book.new
     @books= Book.find(params[:id])
     @user= @books.user
  end

  def edit
     @book = Book.find(params[:id])
  end
  
   def destroy
    book = Book.find(params[:id])  # データ（レコード）を1件取得
    book.destroy  # データ（レコード）を削除
    redirect_to books_path # 投稿一覧画面へリダイレクト  
   end
   
    def update
      @book = Book.find(params[:id])
     if @book.update(book_params)
        flash[:notice]="You have updated book successfully."
      redirect_to book_path(@book.id)
       else
      render :edit
    end
    end

   private

    def book_params
      params.require(:book).permit(:title, :body, :image)
    end
    
     def is_matching_login_user
    book = Book.find(params[:id])
    unless book.id == current_user.id
      redirect_to books_path
    end
  end

end



