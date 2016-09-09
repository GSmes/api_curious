class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices

  validates :name, presence: true
  validates :created_at, presence: true
  validates :updated_at, presence: true

  def self.most_items(quantity)
    joins(invoices: [:transactions, :invoice_items])
      .where(transactions: { result: "success" })
      .group(:id)
      .order("sum(invoice_items.quantity) DESC")
      .limit(quantity)
  end

  def self.order_by_revenue(quantity)
    joins(:invoice_items)
      .group(:id)
      .order("sum(invoice_items.quantity * invoice_items.unit_price) DESC")
      .limit(quantity)
  end

  def total_revenue
    invoices.joins(:transactions, :invoice_items)
      .where(transactions: { result: "success" })
      .sum("invoice_items.quantity * invoice_items.unit_price")
  end

  def revenue_on(date)
    invoices.where(created_at: date)
      .joins(:invoice_items)
      .sum("invoice_items.quantity * invoice_items.unit_price")
  end

  def self.total_revenue_on(date)
    Invoice.where(created_at: date)
      .joins(:invoice_items)
      .sum("invoice_items.quantity * invoice_items.unit_price")
  end

  def customers_with_pending_invoices
    customer_ids = []
    invoices.each do |invoice|
      if invoice.pending?
        customer_ids << invoice.customer_id
      end
    end
    customer_ids
  end

  def favorite_customer
    result = {}
    invoices.each do |invoice|
      result[invoice.customer] ||= 0
      result[invoice.customer] += 1 unless invoice.pending?
    end
    result.key(result.values.max)
  end
end
