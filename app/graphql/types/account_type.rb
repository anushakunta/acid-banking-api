module Types
  class AccountType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :balance, Float, null: false
    field :user_id, Integer, null: false
    field :transactions, [Types::TransactionType], null: true
  end
end
