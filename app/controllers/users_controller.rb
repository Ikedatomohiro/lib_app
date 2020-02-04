class UsersController < ApplicationController
before_action :set_current_user, only:[
                                        :index,
                                        :setting,
                                        :edit,
                                        :update_self_introduction,
                                        :add_book]

    def index
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
        puts params[:publish_impression]
        @user_setting = Setting.find_by(user_id: current_user.id)

        if params[:publish_impression]
            @user_setting.update(publish_impression: '0')
        else
            @user_setting.update(publish_impression: '1')
        end
    end


    def update_setting
        redirect_to user_path
        
    end

    def update_self_introduction
        @user.update(self_introduction_params)
        redirect_to "/users/#{current_user.id}"
        
    end

    def update_publish_impression
        puts 'fasfasfa'

    end

    def impression
        @book = Book.find_by(impression_link: params[:impression_link])
        @impressions = Impression.where(book_id: @book.id)
    end


    def book_info
        
    end

    def reading_history
        
    end

    def request_page

    end

    def add_book
        # すでに登録済かどうか確認する
        isbn = params[:isbn].delete("^0-9")
        book = Book.find_by(isbn: isbn,
                            user_id: current_user.id)
        if book
            @err = 'すでに本棚に入っています。'
        else
            # 感想表示用のリンク名を作成
            unique_id = create_id()
            @book = Book.new(user_id: current_user.id,
                             isbn: isbn,
                             title: params[:h_title],
                             thumbnail: params[:h_thumbnail],
                             impression_link: unique_id)
            @book.save!
        end
        @books = Book.where(user_id: current_user.id)
        redirect_to shelf_path
        # render :template => "users/shelf" なんでこれだと表示してくれないの？
    end

    private
        def set_current_user
            @user = current_user
        end

        def self_introduction_params
            params.require(:user).permit(:account_name, :self_introduction)
        end

        def create_id
            # ランダムな文字列を生成
            random_char = [('a'..'z'), ('A'..'Z'), ('0'..'9')].map { |i| i.to_a }.flatten
            random_id = (0...24).map { random_char[rand(random_char.length)] }.join
            unique_id = check_id(random_id)
            return unique_id
        end

        def check_id(id)
            book = Book.find_by(impression_link: id)
            if book
                create_id()
            else
                return id
            end
        end

end
