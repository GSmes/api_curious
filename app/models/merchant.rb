class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices

  validates :name, presence: true
  validates :created_at, presence: true
  validates :updated_at, presence: true
end
