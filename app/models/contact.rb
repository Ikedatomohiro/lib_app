class Contact < ApplicationRecord
    enum contact_type:{
        ご要望: 0,
        機能: 1,
        ご指摘: 2,
        その他: 3
    }

    validates :contact_type, presence:true
    validates :contact_title, presence:true
    validates :inquiry, presence:true
    validates :user_id, presence:true
end
