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
        redirect_to books_search_books_result_path(keyword: params[:keyword]) #リダイレクトだと値がリセットされるのでダメ。
    end

    def search_books_result
        keyword = params[:keyword]
        uri = URI.encode("https://www.googleapis.com/books/v1/volumes?q=#{keyword}&maxResults=5")
        json = Net::HTTP.get(URI.parse(uri)) #NET::HTTPを利用してAPIを叩く
        @results = JSON.parse(json) #返り値をRubyの配列に変換
    end

    def show_reading_date
    puts params
        @book = Book.find_by(id: params[:book_id])
        respond_to do |format|
            format.html
            format.js
        end
    end

    def set_reading_date
        book = Book.find_by(id: params[:book][:id])
        if params[:reading_start_date]
            book.update(reading_start_date: params[:reading_start_date])
        elsif params[:reading_end_date]
            book.update(reading_end_date: params[:reading_end_date])
        end
        redirect_to "/impression/#{book.impression_link}"
    end


    private
        def book_params
            params.require(:book).permit(:user_id, :isbn)
        end


end
