class Invoice < ActiveRecord::Base
  belongs_to :customer
  belongs_to :merchant
  
  validates :status, presence: true
  validates :created_at, presence: true
  validates :updated_at, presence: true
end