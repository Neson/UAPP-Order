class CreatePaymentReports < ActiveRecord::Migration
  def change
    create_table :payment_reports do |t|
      t.string :account_number
      t.datetime :datetime
      t.float :amout

      t.timestamps
    end
  end
end
