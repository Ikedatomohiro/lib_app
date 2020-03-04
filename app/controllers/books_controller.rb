class BooksController < ApplicationController
      before_action :authenticate_user!, except: [:show_book_info] # ログインしていないときはログインページに移動
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

    def show_book_info
        api_id = params[:api_id]
        # GoogleAPIで本の情報を取得
        api_path = "https://www.googleapis.com/books/v1/volumes/#{api_id}"
        uri = URI.encode("#{api_path}")
        json = Net::HTTP.get(URI.parse(uri)) #NET::HTTPを利用してAPIを叩く
        res = JSON.parse(json) #返り値をRubyの配列に変換
        @book = res

        # 取得した本についての感想を取得
        @impressions = Impression.all_impressions.where(api_id: params[:api_id])
    end

    def create
        # すでに登録済かどうか確認する
        book = Book.find_by(api_path: params[:book][:api_path],
                            user_id: current_user.id)
        if book
            puts 'すでに本棚に入っています。'
        else
            puts '新たに本棚に追加します。'
            # 感想表示用のリンク名を作成
            unique_id = create_id()
            @book = Book.new(user_id: current_user.id,
                             api_path: params[:book][:api_path],
                             api_id: params[:book][:api_id],
                             title: params[:book][:title],
                             author: params[:book][:author],
                             thumbnail: params[:book][:thmumbnail],
                             impression_link: unique_id)
            @book.save!
        end
        @books = Book.where(user_id: current_user.id)
        redirect_to shelf_path
        # render :template => "users/shelf" なんでこれだと表示してくれないの？
    end

    def show_search_form
        @books = Book.new
        respond_to do |format|
            format.html
            format.js
        end
    end

    def search_books
        if params[:keyword].present?
            redirect_to books_search_books_result_path(keyword: params[:keyword]) #リダイレクトだと値がリセットされるのでダメ。
        else
            redirect_to shelf_path
        end
    end

    def search_books_result
        keyword = params[:keyword]
        uri = URI.encode("https://www.googleapis.com/books/v1/volumes?q=#{keyword}&maxResults=10")
        json = Net::HTTP.get(URI.parse(uri)) #NET::HTTPを利用してAPIを叩く
        @results = JSON.parse(json) #返り値をRubyの配列に変換
    end

    def show_reading_date
        @now_date = params[:now_date]
        @book = Book.find_by(id: params[:book_id])
        respond_to do |format|
            format.html
            format.js
        end
    end

    def set_reading_date
        book = Book.find_by(id: params[:id])
        if params[:reading_start_date]
            book.update(reading_start_date: params[:reading_start_date])
        elsif params[:reading_end_date]
            book.update(reading_end_date: params[:reading_end_date])
        end
        redirect_to "/impressions/#{book.impression_link}"
    end


    private
        def create_id
            # ランダムな文字列を生成
            random_char = [('a'..'z'), ('A'..'Z'), ('0'..'9')].map { |i| i.to_a }.flatten
            random_id = (0...24).map { random_char[rand(random_char.length)] }.join
            unique_id = check_id(random_id)
            return unique_id
        end

        def check_id(id)
            book = Book.find_by(impression_link: id)
            if book
                puts 'found same id'
                create_id()
            else
                puts 'confirmed unique id in check_id function'
                return id
            end
        end



end
