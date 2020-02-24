class ImpressionsController < ApplicationController
    before_action :twitter_client, only: [:tweet_impression]

    def show
        # 表示したい本のデータを検索し、Book_idから感想レコードを検索する。
        @book = Book.find_by(impression_link: params[:id])
        api_path = @book.api_path
        uri = URI.encode("#{api_path}")
        json = Net::HTTP.get(URI.parse(uri)) #NET::HTTPを利用してAPIを叩く
        res = JSON.parse(json) #返り値をRubyの配列に変換
        @api_data = res
        @impressions = Impression.where(book_id: @book.id).order(created_at: "DESC")

    end

    def new
        @impression = Impression.new
    end

    def edit
        
    end

    def create
        book = Book.find_by(id: params[:impression][:book_id])
        book.update(evaluation: params[:score])
        if params[:impression][:impression] != ""
            @impression = Impression.new(impression_params)
            @impression.save!
        end
        redirect_to "/impressions/#{book.impression_link}"
    end

    def update
        @impression = Impression.find_by(id: params[:id])
        @impression.update(impression: params[:impression])
    end

    def destroy
        
    end

    def impression
        @book = Book.find_by(impression_link: params[:impression_link])
        @impressions = Impression.where(book_id: @book.id).order(created_at: "DESC")
    end

    def add_impression_field
        @book = Book.find_by(id: params[:book_id])
        @impressions = Impression.new
        respond_to do |format|
            format.html
            format.js
        end
    end

    def tweet_impression
        # @article = Article.new(article_params)
        #     @client.update("#{@article.title}\r")
            @client.update("テスト1\nブログのためテストしています。(後で消します)")
            redirect_to root_path
    end

    private
    def impression_params
        params.require(:impression).permit(:user_id, :book_id, :impression, :impression_img)
    end

    def reading_date_params
        params.permit(:reading_start_date, :reading_end_date)
    end

    def twitter_client
        @client = Twitter::REST::Client.new do |config|
            config.consumer_key        = "ENV['TWITTER_API_KEY']"
            config.consumer_secret     = "ENV['TWITTER_API_SECRET']"
            config.access_token        = "ENV['TWITTER_ACCESS_TOKEN']"
            config.access_token_secret = "ENV['TWITTER_ACCESS_SECRET']"
    end
  end
end
