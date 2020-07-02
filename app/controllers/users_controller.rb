class UsersController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show, :terms_of_service, :privacy_policy, :notice] # ログインしていないときはログインページに移動
    include ApplicationHelper
    before_action :set_home_flg, only: [:index, :show]
    before_action :set_setting_flg, only: [:edit, :setting, :terms_of_service, :privacy_policy, :release_note, :notice]
    before_action :set_bookshelf_flg, only: [:shelf]
    before_action :set_user_setting_info, only: [:setting, :shelf, :update_publish_impression, :change_shelf_type]
    def index
        private_impression_users = User.impression_private
        # Impression, User, BookをINNER JOINしたけどうまくいかなかった。
        # @vals = Impression.all_impressions.where(user_id: private_impression_users.ids).created_desc
        public_users = Setting.where(publish_impression: true)
        @impressions = Impression.all.order(created_at: "DESC")
        @impressions = @impressions.where(user_id: public_users.ids).page(params[:page]).per(20)
    end

    def show
        @book_owner = User.find_by(id: params[:id])
        @books = Book.where(user_id:@book_owner.id).order(created_at: "DESC")
        @books.each do |book|
            book.impressions = Impression.where(user_id: book.user_id,
                                                book_id: book.id)
        end
    end

    def edit
    end

    def setting
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
        if params[:publish_impression] == "true"
            @user_setting.update(publish_impression: true)
        else
            @user_setting.update(publish_impression: false)
        end
    end

    def reading_history
    end

    # 利用規約ページ
    def terms_of_service
    end

    # 個人情報の取扱について説明ページ
    def privacy_policy
    end

    # リリースノート
    def release_note
    end

    def notice
    end

    def job
        
    end

    private
        def self_introduction_params
            params.require(:user).permit(:account_name, :self_introduction, :user_icon)
        end

        def set_user_setting_info
            @user_setting = Setting.find_by(user_id: current_user.id)
        end
end
