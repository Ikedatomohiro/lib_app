class BooksController < ApplicationController
    def index
        @books = Book.where(user_id: current_user.id)
    end

    def new
        @books = Book.new
        respond_to do |format|
            format.html
            format.js
        end
    end

    def create
        puts params[:isbn]
        @books = Book.where(user_id: current_user.id)
        @book  = Book.new(book_params)
        respond_to do |format|
            if @book.save
                format.html
                format.js
            else
                format.js {render :new}
            end
        end
    end

    def search_books
        @books = Book.new
        respond_to do |format|
            format.html
            format.js
        end
    end

    private
    def book_params
        params.require(:book).permit(:user_id, :isbn)
    end


end
