class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :merchants, through: :invoices

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :created_at, presence: true
  validates :updated_at, presence: true

  def favorite_merchant
    merchants.joins(invoices: :transactions)
      .where(transactions: {result: "success"})
      .group(:id)
      .order("count(invoices.merchant_id) DESC").first
  end
end
