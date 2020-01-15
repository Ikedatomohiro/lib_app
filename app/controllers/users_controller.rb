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
        @user = User.find(current_user.id)
        @user.update(
            account_name:      params[:account_name],
            self_introduction: params[:self_introduction]
            )
        redirect_to "/users/#{current_user.id}"
        
    end

    def impression
        
    end

    def bookInfo
        
    end

    private
        def self_introduction_params
            params.require(:user).permit(:account_name, :self_introduction)
        end
end
