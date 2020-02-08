class ImpressionsController < ApplicationController

    def show
        
    end

    def new
        @impression = Impression.new
    end

    def edit
        
    end

    def create
        book = Book.find_by(id: params[:impression][:book_id])
        book.update(evaluation: params[:score])
        if !params[:impression][:impression]
            @impression = Impression.new(impression_params)
            @impression.save!
        end
        redirect_to "/impression/#{book.impression_link}"
    end

    def update
        
    end

    def destroy
        
    end

    def impression
        @book = Book.find_by(impression_link: params[:impression_link])
        @impressions = Impression.where(book_id: @book.id).order(created_at: "DESC")
    end

    def add_impression_field
        @book = Book.find_by(id: params[:book_id])
        @impressions = Impression.new
        respond_to do |format|
            format.html
            format.js
        end
    end

    private
    def impression_params
        params.require(:impression).permit(:user_id, :book_id, :impression)
    end

end
