class AddMoreForeignKeysToInvoices < ActiveRecord::Migration[5.0]
  def change
    add_foreign_key :invoices, :merchants
    add_foreign_key :invoices, :customers
  end
end
