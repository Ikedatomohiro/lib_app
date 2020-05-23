class ShelfItem < ApplicationRecord
    belongs_to :shelf
    belongs_to :book

    # 本の並び替え
    include RankedModel
    ranks :row_shelf_items_order, with_same: :shelf_id # with_sameの部分を書かないと正常に順番が保存されないらしい
end
