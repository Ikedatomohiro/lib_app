class BooksController < ApplicationController
      before_action :authenticate_user!, except: [:show_book_info] # ログインしていないときはログインページに移動
    include BooksHelper
    include ApplicationHelper
    before_action :set_bookshelf_flg, only: [:search_books_result, :show_book_info]

    def index
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
        if signed_in?
            @user_book = Book.find_by(api_id: params[:api_id],
                                      user_id: current_user.id)
        end
        # 取得した本についての感想を取得
        public_users = Setting.where(publish_impression: true)
        @books = Book.where(api_id: params[:api_id]).where(user_id: public_users.ids)
        @impressions = Impression.where(book_id: @books.ids).order(created_at: "DESC")
        @amazon_afi_link = setAmazonAfiLink(params[:api_id])
# アマゾンのアフィリンクを確認しやすくするのに使う。
puts params[:api_id]
puts @amazon_afi_link
    end

    def create
        # すでに登録済かどうか確認する
        book = Book.find_by(api_path: params[:book][:api_path],
                            user_id: current_user.id)
        if params[:book][:thmumbnail]
            thumbnail = params[:book][:thmumbnail]
        else
            thumbnail = '/assets/book_img.svg'
        end
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
                             thumbnail: thumbnail,
                             impression_link: unique_id,
                             row_order_position: 0)
            @book.save!
        end
        @books = Book.where(user_id: current_user.id)
        redirect_to shelf_path
        # render :template => "users/shelf" なんでこれだと表示してくれないの？
    end

    def destroy
        book = Book.find_by(id: params[:id])
        book.destroy
        redirect_to shelf_path
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
        @keyword = params[:keyword]
        uri = URI.encode("https://www.googleapis.com/books/v1/volumes?q=#{@keyword}&maxResults=20")
        json = Net::HTTP.get(URI.parse(uri)) #NET::HTTPを利用してAPIを叩く
        @results = JSON.parse(json) #返り値をRubyの配列に変換
    end

    def search_from_barcode
        if params[:barcode][0].match(/978.*/)
            @keyword = params[:barcode][0]
        elsif params[:barcode][1].match(/978.*/)
            @keyword = params[:barcode][1]
        end
        uri = URI.encode("https://www.googleapis.com/books/v1/volumes?q=#{@keyword}&maxResults=5")
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

    def update_thumbnail
        book = Book.find_by(id: params[:book_id])
        if params[:thumbnail] != ''
puts '////////////////////////////'
            book.update(users_thumbnails_params)
        else
puts '..............................'
            book.update(users_thumbnail: nil)
        end
        redirect_to impression_path(book.impression_link)
    end

    # 本棚の並び替え
    def sort
        book = Book.find_by(id: params[:book_id])
        # book.update(book_sort_params)
        book.update(row_order_position: params[:row_order_position])
        render body: nil
        # render nothing: true この書き方はrails 4までしか使えない

    end

    private
        # 本のサムネイルをユーザーのに更新させる。
        def users_thumbnails_params
            params.require(:book).permit(:users_thumbnail)
        end

        def book_sort_params
            # ranked-model gem の仕様でrow_order_positionを更新する。
            params.require(:book).permit(:row_order_position)
        end


end
