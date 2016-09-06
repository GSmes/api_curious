require 'csv'

namespace :import do
  desc "Import customers from csv"
  task customers: :environment do
    file = File.join Rails.root, "db/data/customers.csv"
    CSV.foreach(file, headers: true) do |row|
      Customer.create(row.to_hash)
    end
  end

  desc "Import invoice items from csv"
  task invoice_items: :environment do
    file = File.join Rails.root, "db/data/invoice_items.csv"
    CSV.foreach(file, headers: true) do |row|
    InvoiceItem.create(row.to_hash)
    end
  end

  desc "Import invoices from csv"
  task invoices: :environment do
    file = File.join Rails.root, "db/data/invoices.csv"
    CSV.foreach(file, headers: true) do |row|
    Invoice.create(row.to_hash)
    end
  end

  desc "Import items from csv"
  task items: :environment do
    file= File.join Rails.root, "Db/data/items.csv"
    CSV.foreach(file, headers: true) do |row|
      Item.create(row.to_hash)
    end
  end

  desc "Import merchants from csv"
  task merchants: :environment do
    file = File.join Rails.root, "db/data/merchants.csv"
    CSV.foreach(file, headers: true) do |row|
      Merchant.create(row.to_hash)
    end
  end

  desc "Import transactions from csv"
  task transactions: :environment do
    file= File.join Rails.root, "Db/data/transactions.csv"
    CSV.foreach(file, headers: true) do |row|
      Transaction.create(row.to_hash)
    end
  end

  desc "Import all csv files"
  task :all => [:customers, :merchants, :items, :invoices, :invoice_items, :transactions]
end
