module Types
  class QueryType < Types::BaseObject
    description "Root Query"

    field :me, Types::UserType, null: true
    field :accounts, [Types::AccountType], null: false
    field :transactions, [Types::TransactionType], null: false do
      argument :account_id, ID, required: false
    end

    def me
      context[:current_user]
    end

    def accounts
      user = context[:current_user]
      return Account.none unless user
      return Account.all if user.admin?
      Account.where(user_id: user.id)
    end

    def transactions(account_id: nil)
      user = context[:current_user]
      return Transaction.none unless user
      scope = user.admin? ? Transaction.all : Transaction.joins(:account).where(accounts: { user_id: user.id })
      scope = scope.where(account_id: account_id) if account_id
      scope.order(created_at: :desc)
    end
  end
end
