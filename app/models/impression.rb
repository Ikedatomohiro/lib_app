class Impression < ApplicationRecord
    belongs_to :user
    belongs_to :book
    validates_presence_of :book_id, :user_id, :impression

    # 画像アップロード
    mount_uploader :impression_img, ImageUploader

    scope :all_impressions, -> {joins(:user ,:book).select("impressions.*, impressions.id AS impression_id, users.*, books.*")}
    scope :created_desc, -> {order(created_at: "DESC")}
end
