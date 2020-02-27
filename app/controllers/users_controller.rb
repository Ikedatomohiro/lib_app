class UsersController < ApplicationController
before_action :set_current_user, only:[ :index,
                                        :setting,
                                        :edit,
                                        :update_self_introduction,
                                        :add_book]

    def index
        private_impression_users = User.impression_private
        # Impression, User, BookをINNER JOIN
        @vals = Impression.all_impressions.where(user_id: private_impression_users.ids).created_desc

    end

    def show
        @user = User.find_by(id: params[:id])
    end

    def edit
    end

    def notice

    end

    def shelf
        @books = Book.where(user_id: current_user.id).order(created_at: "DESC")
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
        def set_current_user
            @user = current_user
        end

        def self_introduction_params
            params.require(:user).permit(:account_name, :self_introduction, :user_icon)
        end
end
