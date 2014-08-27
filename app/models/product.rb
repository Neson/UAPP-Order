class Product < ActiveRecord::Base
  validates_presence_of :name, :price
  validates :price, :numericality => { :greater_than_or_equal_to => 0 }
  validates_uniqueness_of :code, :allow_nil => true, :allow_blank => true
  validates_uniqueness_of :name, :scope => :code

  belongs_to :provider
  has_many :product_tags
  has_many :tags, through: :product_tags

  accepts_nested_attributes_for :product_tags, :allow_destroy => true
end
