class AddConfirmStaffIdToPaymentReport < ActiveRecord::Migration
  def change
    add_column :payment_reports, :confirm_staff_id, :integer
  end
end
