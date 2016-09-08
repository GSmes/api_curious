require 'csv'

namespace :import do
  desc "Import customers from csv"
  task customers: :environment do
    file = File.join Rails.root, "db/data/customers.csv"
    CSV.foreach(file, headers: true) do |row|
      Customer.create!(row.to_hash)
    end
    puts "Imported Customers!"
  end

  desc "Import invoice items from csv"
  task invoice_items: :environment do
    file = File.join Rails.root, "db/data/invoice_items.csv"
    CSV.foreach(file, headers: true) do |row|
      unit_price = row["unit_price"].to_f/100.00
      i = InvoiceItem.create!(row.to_hash)
      i.update_attribute(:unit_price, unit_price)
    end
    puts "Imported Invoice Items!"
  end

  desc "Import invoices from csv"
  task invoices: :environment do
    file = File.join Rails.root, "db/data/invoices.csv"
    CSV.foreach(file, headers: true) do |row|
      Invoice.create!(row.to_hash)
    end
    puts "Imported Invoices!"
  end

  desc "Import items from csv"
  task items: :environment do
    file = File.join Rails.root, "db/data/items.csv"
    CSV.foreach(file, headers: true) do |row|
      unit_price = row["unit_price"].to_f/100.00
      i = Item.create!(row.to_hash)
      i.update_attribute(:unit_price, unit_price)
    end
    puts "Imported Items!"
  end

  desc "Import merchants from csv"
  task merchants: :environment do
    file = File.join Rails.root, "db/data/merchants.csv"
    CSV.foreach(file, headers: true) do |row|
      Merchant.create!(row.to_hash)
    end
    puts "Imported Merchants!"
  end

  desc "Import transactions from csv"
  task transactions: :environment do
    file = File.join Rails.root, "db/data/transactions.csv"
    CSV.foreach(file, headers: true) do |row|
      Transaction.create!(row.to_hash)
    end
    puts "Imported Transactions!"
  end

  desc "Import all csv files"
  task :all => [:customers, :merchants, :items, :invoices, :invoice_items, :transactions]
end
