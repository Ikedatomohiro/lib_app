class ShelvesController < ApplicationController
    include ApplicationHelper
    before_action :authenticate_user!, except: [] # ログインしていないときはログインページに移動
    before_action :set_bookshelf_flg, only: [:index, :show]
    before_action :set_user_setting_info, only: [:index, :show, :change_shelf_type]


    def index
        @shelves = Shelf.where(user_id: current_user.id).rank(:row_shelves_order)
        if @user_setting.latest_shelf == 0
            @books = Book.where(user_id: current_user.id).rank(:row_order)
            @shelves = Shelf.where(user_id: current_user.id).rank(:row_shelves_order)
            book_id_array = []
            puts 'すべての本'
        else
            redirect_to "/shelves/#{@user_setting.latest_shelf}"
        end
    end

    def show
        @shelves = Shelf.where(user_id: current_user.id).rank(:row_shelves_order)
        shelf_id = params[:id]
        shelf = Shelf.find_by(id: shelf_id, user_id: current_user.id)
        if /^[+-]?[0-9]+$/ =~ shelf_id.to_s # バーコードリーダーにJOBを使っていたときの名残
            if shelf_id == "0"
                @user_setting.update(latest_shelf: shelf_id)
                redirect_to shelves_path
            elsif shelf
                @user_setting.update(latest_shelf: shelf_id)
                @shelf_items = ShelfItem.where(user_id: current_user.id,
                                              shelf_id: shelf_id).rank(:row_shelf_items_order)
                puts 'その他の本棚'
            else
                puts '不正なshelf_id'
            end
        else
            puts '不正なshelf_id'
        end
    end

    def add_book
        book_exists = ShelfItem.find_by(shelf_id: params[:shelf_id],
                                        user_id: current_user.id,
                                        book_id: params[:book_id])
        if !book_exists
            book = ShelfItem.new(shelf_id: params[:shelf_id],
                                 user_id: current_user.id,
                                 book_id: params[:book_id],
                                 row_shelf_items_order: 0)
            book.save!
        end

        if params[:current_shelf_id] != 0
            delete_shelf_item
        end
    end

    def delete_shelf_item
        target_book = ShelfItem.find_by(shelf_id: params[:current_shelf_id],
                                        user_id: current_user.id,
                                        book_id: params[:book_id])
        if target_book.present?
            target_book.destroy
        end
    end

    def destroy
        shelf = Shelf.find_by(id: params[:id],
                                user_id: current_user.id)
        shelf.destroy
        redirect_to shelves_path
    end

    # 本棚をカラムとブロックを変更
    def change_shelf_type
        if params[:shelf_type] == '0'
            @user_setting.update(shelf_type: 1)
        elsif params[:shelf_type] == '1'
            @user_setting.update(shelf_type: 0)
        end

        redirect_to shelves_path
    end

    def add_shelf
        if params[:shelf_name]
            shelf = Shelf.new(user_id: current_user.id,
                              shelf_name: params[:shelf_name],
                              row_shelves_order_position: 0)
            shelf.save!
        else
            redirect_to shelves_path
        end
        redirect_to shelves_path
    end

    def sort
        shelf = Shelf.find_by(id: params[:shelf_id])
        shelf.update(row_shelves_order_position: params[:row_order_position])
        render body: nil
    end

    private

        def set_user_setting_info
            @user_setting = Setting.find_by(user_id: current_user.id)
        end

end
