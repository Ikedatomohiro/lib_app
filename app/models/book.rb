class Book < ApplicationRecord
    belongs_to :user
    has_many :impressions

    def tweet
        count = Impression.where(self.id)
        return 'tweet'
        # viewから呼ぶ
    end
end
