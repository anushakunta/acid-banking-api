module Mutations
  class CreateTransaction < GraphQL::Schema::Mutation
    null false
    argument :account_id, ID, required: true
    argument :amount, Float, required: true
    argument :transaction_type, String, required: true
    argument :description, String, required: false

    field :transaction, Types::TransactionType, null: true
    field :errors, [String], null: false

    def resolve(account_id:, amount:, transaction_type:, description: nil)
      user = context[:current_user]
      return { transaction: nil, errors: ["Unauthorized"] } unless user
      account = Account.find_by(id: account_id)
      return { transaction: nil, errors: ["Account not found"] } unless account
      unless user.admin? || account.user_id == user.id
        return { transaction: nil, errors: ["Forbidden"] }
      end

      tx = Transaction.create(account_id: account.id, amount: amount, transaction_type: transaction_type, description: description)
      if tx.persisted?
        # simplistic balance update
        new_balance = account.balance.to_f + (transaction_type == 'credit' ? amount : -amount)
        account.update(balance: new_balance)
        { transaction: tx, errors: [] }
      else
        { transaction: nil, errors: tx.errors.full_messages }
      end
    end
  end
end
