class ShelvesController < ApplicationController
    include ApplicationHelper
    before_action :authenticate_user!, except: [:index, :show, :terms_of_service, :privacy_policy, :notice] # ログインしていないときはログインページに移動
    before_action :set_bookshelf_flg, only: [:index, :show]
    before_action :set_user_setting_info, only: [:index, :show, :change_shelf_type]

    def index

        @shelves = Shelf.where(user_id: current_user.id).rank(:row_order)
        if @user_setting.latest_shelf == 0
            @books = Book.where(user_id: current_user.id).rank(:row_order)
            @shelves = Shelf.where(user_id: current_user.id).rank(:row_order)
            puts 'すべての本'
        else
            shelf_id = @user_setting.latest_shelf
            shelf_items = ShelfItem.where(user_id: current_user.id,
                                          shelf_id: shelf_id)
            book_id_array = []
            shelf_items.each do |item|
                book_id_array.push(item.book_id)
            end
            @books = Book.where(id: book_id_array)
            puts 'その他の本棚'
        end
    end

    def show
        shelf_id = params[:id]
        @user_setting.update(latest_shelf: shelf_id)
        redirect_to shelves_path
    end

    def add_book
        book_exists = ShelfItem.find_by(shelf_id: params[:shelf_id],
                                        user_id: current_user.id,
                                        book_id: params[:book_id])
        if !book_exists
            book = ShelfItem.new(shelf_id: params[:shelf_id],
                                 user_id: current_user.id,
                                 book_id: params[:book_id],
                                 row_order: 0)
            book.save!
        end

        delete_shelf_item

    end

    def delete_shelf_item
puts params[:current_shelf_id]
        if params[:current_shelf_id] != 0
            target_book = ShelfItem.find_by(shelf_id: params[:current_shelf_id],
                                            user_id: current_user.id,
                                            book_id: params[:book_id])
            target_book.destroy
        end
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

        redirect_to shelves_path
    end

    def add_shelf
        if params[:shelf_name]
            shelf = Shelf.new(user_id: current_user.id,
                              shelf_name: params[:shelf_name],
                              row_order_position: 0)
            shelf.save!
        else
            redirect_to shelves_path
        end
        redirect_to shelves_path
    end

    private

        def set_user_setting_info
            @user_setting = Setting.find_by(user_id: current_user.id)
        end

end
