class UsersController < ApplicationController
      before_action :authenticate_user!, except: [:index, :show] # ログインしていないときはログインページに移動

    def index
        private_impression_users = User.impression_private
        # Impression, User, BookをINNER JOIN
        @vals = Impression.all_impressions.where(user_id: private_impression_users.ids).created_desc

puts 'おはようございます。
今日も一日元気に頑張りましょう。
aj;dalj;lkj;lkjsd;kaj;fjkda;jf;lakjf;lkja;lkjflkajlkfjalkdj;afj
コロナウイルスが怖いので、あまり人混みの多いところには行かないほうがいいですね。
通勤される方はマスクを活用し、こまめに消毒することが大切です。
どちらもarimasenn
'.encode("EUC-JP").bytesize


    end

    def show
        @user = User.find_by(id: params[:id])
        @books = Book.where(user_id:@user.id).order(created_at: "DESC")
        @books.each do |book|
            book.impressions = Impression.where(user_id: book.user_id,
                                                book_id: book.id)
        end
    end

    def edit
    end

    def notice

    end

    def shelf
        @books = Book.where(user_id: current_user.id).order(created_at: "DESC")
        @books.each do |book|
        tweet = Impression.where(book_id: book.id,
                                          user_id: current_user.id,
                                          tweeted_flg: true).count
        impression = Impression.where(book_id: book.id,
                                      user_id: current_user.id).count
        # book.push(tweet)
        puts impression
        end
    end

    def setting
        if !Setting.find_by(id: current_user.id)
            @user_setting = Setting.new(user_id: current_user.id)
            @user_setting.save!
        end
        @user_setting = Setting.find_by(user_id: current_user.id)

    end

    def update_setting
        redirect_to user_path
        
    end

    def update_self_introduction
        @user.update(self_introduction_params)
        redirect_to "/users/#{current_user.id}"
    end

    # 感想を公開するかどうかのフラグを変更する。
    def update_publish_impression
        @user_setting = Setting.find_by(user_id: current_user.id)
        if params[:publish_impression] == "true"
            @user_setting.update(publish_impression: true)
        else
            @user_setting.update(publish_impression: false)
        end
    end

    def reading_history
    end

    private
        def self_introduction_params
            params.require(:user).permit(:account_name, :self_introduction, :user_icon)
        end
end
