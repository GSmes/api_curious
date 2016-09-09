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

  def self.order_by_revenue(top_n)
    result = []
    all_revenues_per_merchant = total_revenues
    top_n_revenues = all_revenues_per_merchant.values.sort.reverse.shift(top_n)
    top_n_revenues.each do |revenue|
      result << all_revenues_per_merchant.key(revenue)
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

  def revenue_on(date)
    @revenue = Transaction.merchant_revenue_on_date(date, self.id)
  end

  def customers_with_pending_invoices
    all_invoices = self.invoices
    customer_ids = []
    all_invoices.each do |invoice|
      if invoice.pending?
        customer_ids << invoice.customer_id
      end
    end
    customer_ids
  end

  def favorite_customer
    result = {}
    self.invoices.each do |invoice|
      result[invoice.customer] ||= 0
      result[invoice.customer] += 1 unless invoice.pending?
    end
    result.key(result.values.max)
  end
end
