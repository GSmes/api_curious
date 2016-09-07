class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :items, through: :invoice_items
  
  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true
  validates :merchant_id, presence: true
  validates :created_at, presence: true
  validates :updated_at, presence: true
end
