class Product < ActiveRecord::Base
  validates_presence_of :name, :price
  validates :price, :numericality => { :greater_than_or_equal_to => 0 }
  validates_uniqueness_of :code, :allow_nil => true, :allow_blank => true
  validates_uniqueness_of :name, :scope => :code
end
