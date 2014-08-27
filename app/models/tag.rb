class Tag < ActiveRecord::Base
  validates_presence_of :name

  has_many :product_tags
  has_many :products, through: :product_tags

  accepts_nested_attributes_for :product_tags, :allow_destroy => true
end
