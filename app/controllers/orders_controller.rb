class OrdersController < ApplicationController
  before_action :authenticate_user!, :only => [:batch_create, :my_orders, :update_orders]

  def batch_create
    Order.transaction do
      params[:order].each do |id, q|
        raise 'too many!' if q.to_i > 100
        q.to_i.times do
          o = Product.find(id).orders.new
          o.user = current_user
          o.price = o.product.price
          o.save!
        end
      end
    end
    session[:ordered] = true
    redirect_to my_orders_path
  end

  def my_orders
    if session[:ordered]
      @ordered = true
    else
      @ordered = false
    end
    @orders = current_user.orders.order('created_at desc')
  end

  def update_orders
    if params[:commit] == "回報付款資料"
      action_amount = 0
      should_pay_amount = 0
      params[:order].each do |k, v|
        if v.to_s == '1'
          should_pay_amount += current_user.orders.find(k.to_i).price.to_f
        end
      end
      if should_pay_amount.to_f == params[:payment_report][:amout].to_f
        Order.transaction do
          pr = PaymentReport.new
          pr.datetime = Time.parse(params[:payment_report][:datetime])
          pr.account_number = params[:payment_report][:account_number]
          pr.amout = params[:payment_report][:amout]
          pr.save!

          params[:order].each do |k, v|
            if v.to_s == '1'
              action_amount += 1
              current_user.orders.find(k.to_i).pay(current_user.id, pr.id)
            end
          end
        end
        flash[:notice] = "#{action_amount} 筆訂單已回報付款"
      else
        flash[:alert] = "付款金額與應負金額不符，勾選項目應繳 NT$ #{should_pay_amount}，您的回報資料為 NT$ #{params[:payment_report][:amout]}，若有問題請聯絡工作人員"
      end
    elsif params[:commit] == "取消訂單"
      action_amount = 0
      Order.transaction do
        params[:order].each do |k, v|
          if v.to_s == '1'
            action_amount += 1
            current_user.orders.find(k.to_i).cancel('user', current_user.id)
          end
        end
      end
      flash[:notice] = "#{action_amount} 筆訂單已取消"
    else
      flash[:alert] = "操作失敗"
    end

    redirect_to my_orders_path
  end
end
