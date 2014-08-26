class ProductTag < ActiveRecord::Base
  validates_presence_of :product_id, :tag_id
end
