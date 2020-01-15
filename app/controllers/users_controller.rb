class UsersController < ApplicationController

    def index
      @users = User.all
    end

    def show
        @user = User.find_by(id: params[:id])
    end

    def notice
        
    end

    def shelf
        
    end

    def setting
        
    end

    def edit
        @user = current_user
    end

    def update
        redirect_to user_path
        
    end

    def update_self_introduction
        @user = current_user
        @user.update (
            account_name:      params[:account_name],
            self_introduction: params[:self_introduction]
            )
        redirect_to "/users/#{current_user.id}"
        
    end

    def impression
        
    end

    def bookInfo
        
    end
end
