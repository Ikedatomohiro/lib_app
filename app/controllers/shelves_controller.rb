class ShelvesController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show, :terms_of_service, :privacy_policy, :notice] # ログインしていないときはログインページに移動
    include ApplicationHelper
    before_action :set_bookshelf_flg, only: [:index, :show]
    before_action :set_user_setting_info, only: [:index, :show, :change_shelf_type]
    def index
        if @user_setting.latest_shelf == 0
            @books = Book.where(user_id: current_user.id).rank(:row_order)
            @shelves = Shelf.where(user_id: current_user.id).rank(:row_order)
        else
            @books = Book.where(user_id: current_user.id).rank(:row_order)
            @shelves = Shelf.where(user_id: current_user.id).rank(:row_order)
            render "/shelves/index"
            # redirect_to "/shelves/#{@user_setting.latest_shelf}"
        end
    end

    def show
        shelf_id = params[:id]
        @books = Book.where(user_id: current_user.id)
        @user_setting.update(latest_shelf: shelf_id)
        # if params[:shelf_id] != '0'
        #     @books = ShelfItem.where(user_id: current_user.id,
        #                              shelf_id: )
        # else
        # @books = Book.where(user_id: current_user.id).rank(:row_order)
        # @shelves = Shelf.where(user_id: current_user.id).rank(:row_order)

        # end

# 本棚を切り替える
# 最後に閲覧した本棚情報を保存する「latest_shelf」みたいな感じ。フィールドはsetting。



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
