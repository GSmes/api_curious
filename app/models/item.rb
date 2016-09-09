class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true
  validates :merchant_id, presence: true
  validates :created_at, presence: true
  validates :updated_at, presence: true

  def self.most_items(quantity)
    joins(:invoice_items)
      .group(:id)
      .order("sum(invoice_items.quantity) DESC")
      .limit(quantity)
  end

  def best_day
    invoice_items.joins(:invoice)
      .group("invoices.created_at")
      .order("sum_invoice_items_quantity DESC, invoices_created_at DESC")
      .sum("invoice_items.quantity").first.first
  end
end
