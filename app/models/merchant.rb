class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices

  validates :name, presence: true
  validates :created_at, presence: true
  validates :updated_at, presence: true
  
  def self.order_by_revenue
    total_revenues = {}
    all.each do |merchant|
      total_revenues[merchant] = merchant.total_revenue
    end
  end
  
  def total_revenue
    total_revenue = 0
    self.invoices.each do |invoice|
      invoice.invoice_items.each do |invoice_item|
        total_revenue += invoice_item.quantity * invoice_item.unit_price
      end
    end
    total_revenue
  end
end
