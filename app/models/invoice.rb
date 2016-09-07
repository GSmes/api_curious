class Invoice < ActiveRecord::Base
  # belongs_to :customer
  # belongs_to :merchant
  
  validates :customer_id, presence: true
  validates :merchant_id, presence: true
  validates :status, presence: true
  validates :created_at, presence: true
  validates :updated_at, presence: true
end