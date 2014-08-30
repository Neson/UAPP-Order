class OrdersController < ApplicationController
  before_action :authenticate_user!, :only => [:batch_create, :my_orders]

  def batch_create
    # Order.transaction do
      params[:order].each do |id, q|
        q.to_i.times do
          o = Product.find(id).orders.new
          o.user = current_user
          o.price = o.product.price
          o.save!
        end
      end
    # end
    # cookies[:orderD] = ''
    # cookies.delete :orderD
    redirect_to my_orders_path
  end

  def my_orders
    @orders = current_user.orders
  end
end
