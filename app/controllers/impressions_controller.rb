class ImpressionsController < ApplicationController
    before_action :twitter_client, only: [:post_to_twitter]
    before_action :authenticate_user!, except: [:show] # ログインしていないときはログインページに移動

    def show
        # 表示したい本のデータを検索し、Book_idから感想レコードを検索する。
        @book = Book.find_by(impression_link: params[:id])
        @impressions = Impression.where(book_id: @book.id).order(created_at: "DESC")
        @book_owner = User.find_by(id: @book.user_id)
        # ツイッターカード用のデータをセット
        # 感想ページ所有ユーザーを取得
        @book_owner = User.find_by(id: @book.user_id)
        # ツイッターカードに表示させる画像を投稿した画像にする。なければ、本の画像にする。
        if params[:imp]
            impression = Impression.find_by(id: params[:imp])
            if impression.impression_img.present?
                thumbnail = impression.impression_img
                thumbnail = "https://dokusyo-no-wa.com#{thumbnail}"
            end
        else
            if @book.users_thumbnail.present?
                thumbnail = "https://dokusyo-no-wa.com#{@book.users_thumbnail}"
            else
                thumbnail = @book.thumbnail #GoogleAPIの画像アドレス
            end
        end
puts thumbnail
        if @impressions.first
            @twitter_card = {
                "site"        => "@#{@book_owner.nickname}",
                "image"       => thumbnail,
                "url"         => "https://dokusyo-no-wa.com/impressions/#{@book.impression_link}",
                "title"       => @book.title,
                "description" => @impressions.first.impression,
            }
        end
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
        impression =Impression.find_by(id: params[:id])
        book = Book.find_by(id: impression.book_id)
        impression.destroy
        redirect_to "/impressions/#{book.impression_link}"
    end

    def add_impression_field
        @book = Book.find_by(id: params[:book_id])
        @impressions = Impression.new
        respond_to do |format|
            format.html
            format.js
        end
    end

    # ツイートする。画像があれば画像を付けてツイートする。
    def post_to_twitter
        impression = Impression.find_by(id: params[:id])
        book = Book.find_by(id: impression.book_id)
        # ツイートする画像をセット
        if impression.impression_img.present?
            impression_id = "?imp=#{impression.id}"
        end
        tweet_content = impression.impression.truncate(120)
        tweet = "#{tweet_content}\nhttps://dokusyo-no-wa.com/impressions/#{book.impression_link}#{impression_id}"
        # 画像投稿機能はペンディング。ツイッターカードに画像を表示させる仕様にする。
        # if impression.impression_img
        #     @client.update_with_media(tweet, open("./public#{impression.impression_img}"))
        # else
            @client.update(tweet)
        # # end?
        impression.update(tweeted_flg: true)
        redirect_to impression_path(book.impression_link)
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
            config.consumer_key        = ENV['TWITTER_API_KEY']
            config.consumer_secret     = ENV['TWITTER_API_SECRET']
            config.access_token        = current_user.oauth_token
            config.access_token_secret = current_user.oauth_token_secret
    end
  end
end
