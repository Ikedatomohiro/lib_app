class Contact < ApplicationRecord
    enum contact_type:{
        ご利用の感想: 0,
        機能追加の要望: 1,
        ご指摘: 2,
        その他: 3
    }

    validates :contact_type, presence:true
    validates :contact_title, presence:true
    validates :inquiry, presence:true
    validates :user_id, presence:true
end
