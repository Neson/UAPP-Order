class OrdersController < ApplicationController
  before_action :authenticate_user!, :only => [:batch_create, :my_orders]

  def batch_create
    # Order.transaction do
      params[:order].each do |id, q|
        raise 'too many!' if q.to_i > 100
        q.to_i.times do
          o = Product.find(id).orders.new
          o.user = current_user
          o.price = o.product.price
          o.save!
        end
      end
    # end
    session[:ordered] = true
    redirect_to my_orders_path
  end

  def my_orders
    if session[:ordered]
      @ordered = true
    else
      @ordered = false
    end
    @orders = current_user.orders
  end

  def update_orders
  end
end
