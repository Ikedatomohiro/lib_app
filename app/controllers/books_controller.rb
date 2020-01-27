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

    def show
    end

    def show_book_info
        puts params[:isbn]
    end

    def create
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

    def show_search_form
        @books = Book.new
        respond_to do |format|
            format.html
            format.js
        end
    end

    def search_books
        keyword = params[:keyword]
        uri = URI.encode("https://www.googleapis.com/books/v1/volumes?q=#{keyword}&maxResults=3")
        puts uri
        # json = Net::HTTP.get(URI.parse(uri)) #NET::HTTPを利用してAPIを叩く
        # @result = JSON.parse(json) #返り値をRubyの配列に変換
        # render template: "books/search_books"
        render :template => "books/search_books"
        # redirect_to book_search_path
        # puts @result.volumeInfo.title
        # puts @result.publishDate

    end

    private
        def book_params
            params.require(:book).permit(:user_id, :isbn)
        end


end
