class Shelf < ApplicationRecord
    belongs_to :user
    has_many :shelf_items, dependent: :destroy

    # 本棚の並び替え
    # include RankedModel
    # ranks :row_order, with_same: :user_id # with_sameの部分を書かないと正常に順番が保存されないらしい

end
