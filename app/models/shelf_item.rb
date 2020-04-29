class ShelfControll < ApplicationRecord
    belongs_to :shelf
    belongs_to :book
end
