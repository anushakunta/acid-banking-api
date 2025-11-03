# Banking Dashboard Backend — Rails + GraphQL + JWT + Roles

## Quick Start
```bash
bundle install
rails db:create db:migrate db:seed
rails s
```
GraphQL endpoint: `POST /graphql`

### Auth
- Sign up -> returns JWT (role=member by default)
- Login -> returns JWT
- Send requests with header: `Authorization: Bearer <token>`

### Sample Queries/Mutations
```graphql
mutation { signUp(email: "me@x.com", password: "Password1!") { token user { id email role } errors } }
mutation { login(email: "admin@example.com", password: "Password1!") { token user { id email role } errors } }
query { me { id email role } }
query { accounts { id name balance } }
mutation { createAccount(name: "Team Ops", userId: 2) { account { id name } errors } } # admin only
mutation { createTransaction(accountId: 1, amount: 25.5, transactionType: "debit", description: "Coffee") { transaction { id amount account { id balance } } errors } }
```
