class Transaction < ApplicationRecord
  belongs_to :invoice

  validates :credit_card_number, presence: true
  validates :result, presence: true
  validates :created_at, presence: true
  validates :updated_at, presence: true
  
  def self.revenue_on_date(date)
    successful_transactions = on_date(date)
    @total_revenue = 0
    successful_transactions.each do |transaction|
      transaction.invoice.invoice_items.each do |ii|
        @total_revenue += ii.calculate_revenue
      end
    end
    @total_revenue
  end
  
  def self.on_date(date)
    all.where(updated_at: date, result: "success")
  end
end
