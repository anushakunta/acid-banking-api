module Types
  class TransactionType < Types::BaseObject
    field :id, ID, null: false
    field :amount, Float, null: false
    field :transaction_type, String, null: false
    field :description, String, null: true
    field :account_id, Integer, null: false
    field :account, Types::AccountType, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
