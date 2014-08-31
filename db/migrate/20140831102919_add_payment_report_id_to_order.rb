class AddPaymentReportIdToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :payment_report_id, :integer
  end
end
