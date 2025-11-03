module Types
  class MutationType < Types::BaseObject
    field :sign_up, mutation: Mutations::SignUp
    field :login, mutation: Mutations::Login
    field :create_account, mutation: Mutations::CreateAccount
    field :create_transaction, mutation: Mutations::CreateTransaction
  end
end
