class OrderState < ActiveRecord::Base
  validates_inclusion_of :action, :in => ["rollback", "create", "cancel", "pay", "payment_received", "payment_confirmed", "delivered", "issue", "exchange", "refund", "refunded", "RPR"]
  validates_inclusion_of :state, :in => ["new", "cancelled", "confirming", "paid", "delivered", "problem", "exchanging", "refunding"]

  belongs_to :user
  belongs_to :staff
  belongs_to :order

  scope :payment_confirmeds, -> { where(action: 'payment_confirmed').order('created_at ASC') }
  scope :payment_receiveds, -> { where(action: 'payment_received').order('created_at ASC') }
  scope :delivereds, -> { where(action: 'delivered').order('created_at ASC') }
  scope :issues, -> { where(action: 'issue').order('created_at ASC') }
end
