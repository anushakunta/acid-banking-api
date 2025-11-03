admin = User.create!(email: 'admin@example.com', password: 'Password1!', role: :admin)
member = User.create!(email: 'user@example.com', password: 'Password1!', role: :member)

acc1 = Account.create!(user: member, name: 'Primary Checking', balance: 1250.75)
acc2 = Account.create!(user: member, name: 'Savings Account', balance: 5000.00)

Transaction.create!([
  { account: acc1, amount: 200.00, transaction_type: 'credit', description: 'Salary Deposit' },
  { account: acc1, amount: 50.00, transaction_type: 'debit', description: 'Groceries' },
  { account: acc2, amount: 1000.00, transaction_type: 'credit', description: 'Savings Transfer' }
])
