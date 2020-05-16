class Book < ApplicationRecord
    belongs_to :user
    has_many :impressions, dependent: :destroy
    has_many :shelf_items, dependent: :destroy

    mount_uploader :users_thumbnail, ImageUploader#ここではImageuploader

    # 本の並び替え
    include RankedModel
    ranks :row_order, with_same: :user_id # with_sameの部分を書かないと正常に順番が保存されないらしい

end
