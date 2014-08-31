class PaymentReport < ActiveRecord::Base
  has_many :orders
  belongs_to :confirm_staff, class_name: "Staff"

  validates_presence_of :account_number, :datetime
  validates :amout, :numericality => { :greater_than_or_equal_to => 0 }
end
