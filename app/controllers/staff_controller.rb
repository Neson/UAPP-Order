class StaffController < ApplicationController
  before_action :authenticate_staff!

  def index
  end

  def rollback
    Order.transaction do
      if session[:staff_actions].class == Array
        action_amount = 0
        session[:staff_actions].each do |order_id|
          action_amount += 1
          Order.find(order_id).lock!.rollback(current_staff.id)
        end
        flash[:warning] = "已復原 #{action_amount} 筆資料"
      else
        flash[:alert] = "沒有可復原的操作"
      end
    end
    redirect_to session[:page_history][1]
  end

  def confirm_payment
    @unconfirmed_payment_reports = PaymentReport.where('confirmed = ?', false).order('created_at asc')
  end

  def confirm_payment_update
    session[:staff_actions] = []
    Order.transaction do
      pr = PaymentReport.find(params[:payment_report_id])
      pr.confirm_staff = current_staff
      pr.confirmed = true
      pr.save
      pr.orders.each do |o|
        session[:staff_actions].push o.id
        o.payment_confirmed(current_staff.id)
      end
    end
    flash[:notice] = '確認成功'
    redirect_to confirm_payment_path
  end

  def receive_payment
  end

  def receive_payment_show
    @user = User.where('student_id = ?', params[:sid].downcase).first
    @user = User.from_rfid(params[:sid].downcase) if @user.to_s == ''
    if @user.to_s == ''
      flash[:alert] = '用戶不存在'
      redirect_to receive_payment_path
    else
      @orders = @user.orders.where('state = ?', 'new').order('product_id asc')
    end
  end

  def receive_payment_update
    session[:staff_actions] = []
    action_amount = 0
    Order.transaction do
      if !!params[:order]
        params[:order].each do |k, v|
          if v.to_s == '1'
            action_amount += 1
            session[:staff_actions].push k.to_i
            Order.find(k.to_i).payment_received(current_staff.id)
          end
        end
        flash[:notice] = "<div class=\"action\"><form action=\"/staff/rollback\" method=\"post\"><input type=\"hidden\" name=\"authenticity_token\" value=\"#{form_authenticity_token}\"><input type=\"submit\" value=\"復原\"></form></div>#{action_amount} 筆訂單更新成功"
      else
        flash[:notice] = "沒有更新"
      end
    end
    redirect_to receive_payment_path
  end

  def deliver
  end

  def deliver_show
    @user = User.where('student_id = ?', params[:sid].downcase).first
    @user = User.from_rfid(params[:sid].downcase) if @user.to_s == ''
    if @user.to_s == ''
      flash[:alert] = '用戶不存在'
      redirect_to deliver_path
    else
      @orders = @user.orders.where('state = ?', 'paid').order('product_id asc')
    end
  end

  def deliver_update
    session[:staff_actions] = []
    action_amount = 0
    Order.transaction do
      if !!params[:order]
        params[:order].each do |k, v|
          if v.to_s == '1'
            action_amount += 1
            session[:staff_actions].push k.to_i
            Order.find(k.to_i).lock!.delivered(current_staff.id)
          end
        end
        flash[:notice] = "<div class=\"action\"><form action=\"/staff/rollback\" method=\"post\"><input type=\"hidden\" name=\"authenticity_token\" value=\"#{form_authenticity_token}\"><input type=\"submit\" value=\"復原\"></form></div>#{action_amount} 筆訂單更新成功"
      else
        flash[:notice] = "沒有更新"
      end
    end
    redirect_to deliver_path
  end

  def issue
  end

  def issue_show
    @user = User.where('student_id = ?', params[:sid].downcase).first
    @user = User.from_rfid(params[:sid].downcase) if @user.to_s == ''
    if @user.to_s == ''
      flash[:alert] = '用戶不存在'
      redirect_to receive_payment_path
    else
      @orders = @user.orders.where(['state = ?', 'delivered']).order('product_id asc')
    end
  end

  def issue_update
    action_amount = 0
    Order.transaction do
      if !!params[:order]
        params[:order].each do |k, v|
          if v.to_s == '1'
            action_amount += 1
            Order.find(k.to_i).lock!.issue(current_staff.id)
          end
        end
        flash[:notice] = "#{action_amount} 筆訂單已標記為「客服問題」"
      else
        flash[:notice] = "沒有更新"
      end
    end
    redirect_to issue_path
  end

  def show_user_data
    @user = User.where('uid = ?', params[:uid]).find(params[:id])
  end

end
