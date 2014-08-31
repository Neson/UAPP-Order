class AddConfirmedToPaymentReport < ActiveRecord::Migration
  def change
    add_column :payment_reports, :confirmed, :boolean, :null => false, :default => false
  end
end
