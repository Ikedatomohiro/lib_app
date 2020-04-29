class ShelvesController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show, :terms_of_service, :privacy_policy, :notice] # ログインしていないときはログインページに移動
    include ApplicationHelper
    before_action :set_home_flg, only: [:index, :show]
    before_action :set_setting_flg, only: [:index]
    before_action :set_bookshelf_flg, only: [:index]
    before_action :set_user_setting_info, only: [:index, :change_shelf_type]
    def index
        @books = Book.where(user_id: current_user.id).rank(:row_order)
        @books.each do |book|
        tweet = Impression.where(book_id: book.id,
                                          user_id: current_user.id,
                                          tweeted_flg: true).count
        impression = Impression.where(book_id: book.id,
                                      user_id: current_user.id).count
        @shelves = Shelf.where(user_id: current_user.id).rank(:row_order)
        end
    end

    def show
        
    end

    def delete
        
    end

    # 本棚をカラムとブロックを変更
    def change_shelf_type
        if params[:shelf_type] == '0'
            @user_setting.update(shelf_type: 1)
        elsif params[:shelf_type] == '1'
            @user_setting.update(shelf_type: 0)
        end

        redirect_to shelf_path
    end

    def add_shelf
        if params[:shelf_name]
            shelf = Shelf.new(user_id: current_user.id,
                              shelf_name: params[:shelf_name],
                              row_order_position: 0)
            shelf.save!
        else
            redirect_to shelf_path
        end
        redirect_to shelf_path
    end

    private

        def set_user_setting_info
            @user_setting = Setting.find_by(user_id: current_user.id)
        end

end
