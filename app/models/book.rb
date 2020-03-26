class Book < ApplicationRecord
    belongs_to :user
    has_many :impressions, dependent: :destroy

    mount_uploader :users_thumbnail, ImageUploader#ここではImageuploader

    # 本棚の並び替え
    include RankedModel
    ranks :row_order, with_sama: :user_id # with_sameの部分を書かないと正常に順番が保存されないらしい

    def tweet
        count = Impression.where(self.id)
        return 'tweet'
        # viewから呼ぶ
    end

end
