class ShelvesController < ApplicationController

    def index
        @books = Book.where(user_id: current_user.id).rank(:row_order)
        @books.each do |book|
        tweet = Impression.where(book_id: book.id,
                                          user_id: current_user.id,
                                          tweeted_flg: true).count
        impression = Impression.where(book_id: book.id,
                                      user_id: current_user.id).count
        end
    end

    def show
        
    end

    def delete
        
    end
end
