module Mutations
  class SignUp < GraphQL::Schema::Mutation
    null false
    argument :email, String, required: true
    argument :password, String, required: true

    field :token, String, null: true
    field :user, Types::UserType, null: true
    field :errors, [String], null: false

    def resolve(email:, password:)
      user = User.new(email: email, password: password, role: 'member')
      if user.save
        token = JwtService.encode({ user_id: user.id })
        { token: token, user: user, errors: [] }
      else
        { token: nil, user: nil, errors: user.errors.full_messages }
      end
    end
  end
end
