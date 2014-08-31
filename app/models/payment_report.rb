class PaymentReport < ActiveRecord::Base
  belongs_to :order

  validates_presence_of :account_number, :datetime
  validates :amout, :numericality => { :greater_than_or_equal_to => 0 }
end
