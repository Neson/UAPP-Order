class StaffController < ApplicationController
  before_action :authenticate_staff!

  def index
  end

  def confirm_payment
    @unconfirmed_payment_reports = PaymentReport.where('confirmed = ?', false).order('created_at asc')
  end

  def confirm_payment_update
    Order.transaction do
      pr = PaymentReport.find(params[:payment_report_id])
      pr.confirm_staff = current_staff
      pr.confirmed = true
      pr.save
      pr.orders.each do |o|
        o.payment_confirmed(current_staff.id)
      end
    end
    flash[:notice] = '確認成功'
    redirect_to confirm_payment_path
  end

  def show_user_data
    @user = User.where('uid = ?', params[:uid]).find(params[:id])
  end

end
