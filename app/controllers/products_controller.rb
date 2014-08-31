class ProductsController < ApplicationController

  def index
    @can_order = can_order
    @products = Product.all.order('name ASC')
  end
end
