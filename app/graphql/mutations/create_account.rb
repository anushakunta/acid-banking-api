module Mutations
  class CreateAccount < GraphQL::Schema::Mutation
    null false
    argument :name, String, required: true
    argument :user_id, ID, required: true

    field :account, Types::AccountType, null: true
    field :errors, [String], null: false

    def resolve(name:, user_id:)
      user = context[:current_user]
      return { account: nil, errors: ["Unauthorized"] } unless user&.admin?
      account = Account.new(name: name, user_id: user_id, balance: 0)
      if account.save
        { account: account, errors: [] }
      else
        { account: nil, errors: account.errors.full_messages }
      end
    end
  end
end
