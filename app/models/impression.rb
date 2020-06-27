class Impression < ApplicationRecord
    belongs_to :user
    belongs_to :book
    has_many :likes, dependent: :destroy
    validates_presence_of :book_id, :user_id, :impression

    # 画像アップロード
    mount_uploader :impression_img, ImageUploader

    # すでにいいねしたかどうかチェック
    def already_like(user_id)
        likes.find_by(user_id: user_id)
    end

    scope :created_desc, -> {order(created_at: "DESC")}
end
