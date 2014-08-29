class ProductsController < ApplicationController

  def index
    @products = Product.all.order('name ASC')
  end
end
