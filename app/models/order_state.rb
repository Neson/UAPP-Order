class OrderState < ActiveRecord::Base
  validates_inclusion_of :action, :in => ["create", "cancel", "pay", "payment_received", "payment_confirmed", "delivered", "issue", "exchange", "refund", "refunded"]
  validates_inclusion_of :state, :in => ["new", "cancelled", "confirming", "paid", "delivered", "problem", "exchanging", "refunding"]
end
