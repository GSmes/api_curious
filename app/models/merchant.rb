class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices

  validates :name, presence: true
  validates :created_at, presence: true
  validates :updated_at, presence: true
  
  def self.order_by_revenue(top_n)
    result = []
    top_n_revenues = total_revenues.values.sort.reverse.shift(top_n)
    top_n_revenues.each do |revenue|
      result << total_revenues.key(revenue)
    end
    result
  end
  
  def self.total_revenues
    total_revenues = {}
    all.each do |merchant|
      total_revenues[merchant] = merchant.total_revenue.round(2)
    end
    total_revenues
  end
  
  def total_revenue
    total_revenue = 0
    self.invoices.each do |invoice|
      invoice.invoice_items.each do |invoice_item|
        total_revenue += invoice_item.quantity * invoice_item.unit_price
      end
    end
    total_revenue.to_f.round(2)
  end
end
