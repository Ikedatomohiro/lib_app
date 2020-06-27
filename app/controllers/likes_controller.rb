class LikesController < ApplicationController

    def show
        
    end

    def create
        @impression = Impression.find_by(id: params[:impression_id])

        unless signed_in?
            @impression.like_count += 1
            @impression.update_columns(like_count: @impression.like_count)
        end
        if signed_in? && params[:user_id].present? && @impression.likes.find_by(user_id: current_user.id).blank?
            @impression.like_count += 1
            @impression.update_columns(like_count: @impression.like_count)
            like = Like.create(impression_id: like_params[:impression_id], user_id: like_params[:user_id])
        end
    end

    def destroy
        @impression = Impression.find_by(id: params[:impression_id])
        unless signed_in?
            if @impression.like_count > 0
                @impression.like_count -= 1
                @impression.update_columns(like_count: @impression.like_count)
            end
        end
        if signed_in? && params[:user_id].present? && @impression.likes.find_by(user_id: current_user.id).present? && @impression.like_count > 0
            @impression.like_count -= 1
            @impression.update_columns(like_count: @impression.like_count)
            like = Like.find_by(impression_id: like_params[:impression_id], user_id: like_params[:user_id])
            like.destroy!
        end
    end

    private
    def like_params
        params.permit(:impression_id, :user_id, :authenticity_token)
    end

end
