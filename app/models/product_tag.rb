class ProductTag < ActiveRecord::Base
  validates_presence_of :product_id, :tag_id

  belongs_to :product
  belongs_to :tag
end
