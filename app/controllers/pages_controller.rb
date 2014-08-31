class PagesController < ApplicationController

  def welcome
  end

  def order_notice
    @order_notice = Preference.order_notice
  end
end
