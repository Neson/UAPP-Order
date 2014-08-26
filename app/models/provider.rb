class Provider < ActiveRecord::Base
  validates_uniqueness_of :code, :allow_nil => true, :allow_blank => true
  validates_uniqueness_of :name, :scope => :code
end
