class UsersController < ApplicationController

    def index
        @user = current_user
    end

    def show
        @user = User.find_by(id: params[:id])
    end

    def notice
        
    end

    def shelf
        @shelf = Book.where(user_id: current_user.id)
    end

    def setting
        puts params[:publish_impression]
        @user = current_user
        @user_setting = Setting.find_by(user_id: current_user.id)

        if params[:publish_impression]
            @user_setting.update(publish_impression: '0')
        else
            @user_setting.update(publish_impression: '1')
        end
    end

    def edit
        @user = current_user
    end

    def update_setting
        redirect_to user_path
        
    end

    def update_self_introduction
        @user = User.find(current_user.id)
        @user.update(self_introduction_params)
        redirect_to "/users/#{current_user.id}"
        
    end

    def update_publish_impression
        puts 'fasfasfa'
    end

    def bookInfo
        
    end

    def request_page

    end

    private
        def self_introduction_params
            params.require(:user).permit(:account_name, :self_introduction)
        end
end
