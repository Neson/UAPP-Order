class ProductTag < ActiveRecord::Base
  validates_presence_of :product_id, :tag_id
  validates_uniqueness_of :tag_id, :scope => :product_id

  belongs_to :product
  belongs_to :tag
end
