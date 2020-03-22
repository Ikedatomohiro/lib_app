class Book < ApplicationRecord
    belongs_to :user
    has_many :impressions, dependent: :destroy

    mount_uploader :users_thumbnail, ImageUploader#ここではImageuploader


    def tweet
        count = Impression.where(self.id)
        return 'tweet'
        # viewから呼ぶ
    end

end
