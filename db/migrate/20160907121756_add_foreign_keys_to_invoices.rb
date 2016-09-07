class AddForeignKeysToInvoices < ActiveRecord::Migration[5.0]
  def change
    add_index :invoices, :merchant_id
    add_index :invoices, :customer_id
  end
end
