class Impression < ApplicationRecord
    belongs_to :user
    belongs_to :book
    validates_presence_of :book_id, :user_id, :impression

    # 画像アップロード
    mount_uploader :impression_img, ImageUploader

    scope :all_impressions, -> {joins(:user ,:book).select("impressions.*,
                                                            impressions.id AS impression_id,
                                                            impressions.updated_at AS impression_updated_at,
                                                            users.*,
                                                            books.*,
                                                            books.api_id AS api_id"
                                                            )}
    scope :created_desc, -> {order(created_at: "DESC")}
end
