class ProductsController < ApplicationController

  def index
    @can_order = can_order
    @products = Product.all.order('name ASC').includes(:provider, :tags)
    @latest_product = Product.order('updated_at DESC').first
    @tags = Tag.all.order('name ASC')
  end
end
