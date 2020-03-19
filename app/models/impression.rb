class Impression < ApplicationRecord
    belongs_to :user
    belongs_to :book
    validates_presence_of :book_id, :user_id, :impression

    # 画像アップロード
    mount_uploader :impression_img, ImageUploader

    scope :created_desc, -> {order(created_at: "DESC")}
end
