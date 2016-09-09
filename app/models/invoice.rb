class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions

  validates :customer_id, presence: true
  validates :merchant_id, presence: true
  validates :status, presence: true
  validates :created_at, presence: true
  validates :updated_at, presence: true
  
  def pending?
    results = self.transactions.pluck(:result)
    if results.include?("failed")
      return results.exclude?("success")
    else
      return false
    end
  end
end
