class LikesController < ApplicationController

    def show
        
    end

    def create
        @impression = Impression.find_by(id: params[:impression_id])
        @impression.like_count += 1
        @impression.update(like_count: @impression.like_count)
        if signed_in? && params[:user_id].present?
            like = Like.create(impression_id: like_params[:impression_id], user_id: like_params[:user_id])
        end
    end

    def destroy
        @impression = Impression.find_by(id: params[:impression_id])
        @impression.like_count -= 1
        @impression.update(like_count: @impression.like_count)
        if signed_in? && params[:user_id].present?
            like = Like.find_by(impression_id: like_params[:impression_id], user_id: like_params[:user_id])
            like.destroy!
        end
    end

    private
    def like_params
        params.permit(:impression_id, :user_id, :authenticity_token)
    end

end
