class Order < ActiveRecord::Base
  validates :price, :numericality => { :greater_than_or_equal_to => 0 }
  # validates_inclusion_of :state, :in => ["new", "cancelled", "confirming", "paid", "delivered", "problem", "exchanging", "refunding"]

  belongs_to :product, :counter_cache => true
  belongs_to :user
  has_many :states, class_name: "OrderState"
  belongs_to :payment_report

  after_create :set_new_state, :update_state
  after_update :update_state

  def update_state
    update_column('state', states.last.state.to_s)
  end

  def pay(oid, prid)
    if state == 'new' || state == 'confirming'
      self.payment_report_id = prid
      save!
      pr = PaymentReport.find(self.payment_report_id)
      set_state('user', oid, 'pay', 'confirming')
    else
      raise 'illegal action'
    end
  end

  def cancel(identity, oid)
    if state == 'new'
      set_state(identity, oid, 'cancel', 'cancelled')
    else
      raise 'illegal action'
    end
  end

  def issue
    current_staff
    current_userwhere
  end

  def payment_received(oid)
    if state == 'new'
      set_state('staff', oid, 'payment_received', 'paid')
    else
      raise 'illegal action'
    end
  end

  def payment_confirmed(oid)
    if state == 'confirming'
      set_state('staff', oid, 'payment_confirmed', 'paid')
    else
      raise 'illegal action'
    end
  end

  def delivered(oid)
    if state == 'paid'
      set_state('staff', oid, 'delivered', 'delivered')
    else
      raise 'illegal action'
    end
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
    elsif identity == 'admin'
      s.staff_id = nil
    else
      raise 'illegal identity'
    end
    s.save!
    update_state
  end
end
