class Order < ActiveRecord::Base
  validates :price, :numericality => { :greater_than_or_equal_to => 0 }
  # validates_inclusion_of :state, :in => ["new", "cancelled", "confirming", "paid", "delivered", "problem", "exchanging", "refunding"]

  belongs_to :product
  belongs_to :user
  has_many :states, class_name: "OrderState"
  has_one :payment_report

  after_create :set_new_state, :update_state
  after_update :update_state

  def update_state
    update_column('state', states.last.state.to_s)
  end

  def pay(oid, prid)
    if state == 'new' || state == 'confirming'
      payment_report_id = prid
      save!
      set_state('user', oid, 'pay', 'confirming')
    else
      raise 'illegal action'
    end
  end

  def cancel(identity, oid)
    set_state(identity, oid, 'cancel', 'cancelled')
  end

  def issue
    current_staff
    current_userwhere
  end

  def payment_received
    current_staff
  end

  def payment_confirmed
    current_staff
  end

  def delivered
    current_staff
  end

  def exchange
    current_staff
  end

  def refund
    current_staff
  end

  def refunded
    current_staff
  end

  def set_new_state
    set_state('user', user_id, 'create', 'new')
  end

  def set_state(identity, oid, an, sn)
    s = states.new
    s.action = an
    s.state = sn
    if identity == 'user'
      s.user_id = oid
    elsif identity == 'staff'
      s.staff_id = oid
    else
      raise 'illegal identity'
    end
    s.save!
    update_state
  end
end
