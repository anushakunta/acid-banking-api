class Transaction < ApplicationRecord
  belongs_to :account
  validates :amount, numericality: true
  validates :transaction_type, inclusion: { in: %w[credit debit] }
end
