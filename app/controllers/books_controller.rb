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
        user_setting = Setting.find_by(user_id: current_user.id)
        user_setting.update(latest_shelf: 0)
        redirect_to shelves_path
        # render :template => "users/shelf" なんでこれだと表示してくれないの？
    end

    def update
        @book = Book.find_by(id: params[:id])
        @book.update(reading_start_date: book_edit_params[:reading_start_date],
                     reading_end_date: book_edit_params[:reading_end_date],
                     evaluation: book_edit_params[:score])
    end

    def destroy
        if params[:current_shelf_id] == '0'
            book = Book.find_by(id: params[:id])
        else
            book = ShelfItem.find_by(shelf_id: params[:current_shelf_id],
                                     user_id: current_user.id,
                                     book_id: params[:id])
        end
        book.destroy
        redirect_to '/shelves'
    end

    def search_books
        if params[:keyword].present?
            redirect_to books_search_books_result_path(keyword: params[:keyword]) #リダイレクトだと値がリセットされるのでダメ。
        else
            redirect_to shelves_path
        end
    end

    def search_books_result
        @keyword = params[:keyword]
        uri = URI.encode("https://www.googleapis.com/books/v1/volumes?q=#{@keyword}&maxResults=20")
        json = Net::HTTP.get(URI.parse(uri)) #NET::HTTPを利用してAPIを叩く
        @results = JSON.parse(json) #返り値をRubyの配列に変換
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


    def search_by_isbn
        api_key = ENV['GOOGLE_VISION_API_KEY']
        api_url = "https://vision.googleapis.com/v1/images:annotate?key=#{api_key}"

        # 画像をbase64にエンコード
        base64_image = Base64.strict_encode64(File.new(params[:book_isbn_area], 'rb').read)

        # APIリクエスト用のJSONパラメータの組み立て
        body = {
          requests: [{
            image: {
              content: base64_image
            },
            features: [
              {
                type: 'TEXT_DETECTION',
                maxResults: 5
              }
            ]
          }]
        }.to_json

        # Google Cloud Vision APIにリクエスト投げる
        uri = URI.parse(api_url)
        https = Net::HTTP.new(uri.host, uri.port)
        https.use_ssl = true
        request = Net::HTTP::Post.new(uri.request_uri)
        request["Content-Type"] = "application/json"
        response = https.request(request, body)
        # puts response.body レスポンスのJSONは「response.body」に入っている
        # レスポンスを配列に変換
        results = JSON.parse(response.body)
        # descriptionの中のISBN番号を取り出す
        results['responses'][0]['textAnnotations'].each  do |text|
            isbn = text['description'].match(/978\d{10}/)
            if isbn[0].present?
                # 取得したISBN番号で本の検索をする
                uri_book = URI.encode("https://www.googleapis.com/books/v1/volumes?q=#{isbn[0]}&maxResults=5")
                json = Net::HTTP.get(URI.parse(uri_book)) #NET::HTTPを利用してAPIを叩く
                @results = JSON.parse(json) #返り値をRubyの配列に変換
                # 検索が終わったら処理を終わる
                break
            end
        end
    end

    # 本の並び替え
    def sort
        if params[:current_shelf_id] == '0'
            book = Book.find_by(id: params[:book_id])
            book.update(row_order_position: params[:row_order_position])
        else
            book = ShelfItem.find_by(shelf_id: params[:current_shelf_id],
                                     user_id: current_user.id,
                                     book_id: params[:book_id])
            book.update(row_shelf_items_order_position: params[:row_order_position])
        end
        # book.update(book_sort_params)
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

        def book_edit_params
            params.permit(:reading_start_date, :reading_end_date, :score)
            
        end

end
