class Order < ActiveRecord::Base
  validates :price, :numericality => { :greater_than_or_equal_to => 0 }
  # validates_inclusion_of :state, :in => ["new", "cancelled", "confirming", "paid", "delivered", "problem", "exchanging", "refunding"]

  belongs_to :product
  belongs_to :user
  has_many :states, class_name: "OrderState"

  after_create :set_new_state, :update_state
  after_update :update_state

  def update_state
    update_column('state', states.last.state.to_s)
  end

  def set_new_state
    s = states.new
    s.action = 'create'
    s.state = 'new'
    s.user_id = user_id
    s.save!
  end
end
