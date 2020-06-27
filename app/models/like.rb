class Like < ApplicationRecord
    belongs_to :user
    belongs_to :impression
    validates_presence_of :user_id, :impression_id


end
