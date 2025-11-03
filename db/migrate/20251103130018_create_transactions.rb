class CreateTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :transactions do |t|
      t.references :account, null: false, foreign_key: true
      t.decimal :amount, precision: 12, scale: 2, null: false
      t.string :transaction_type, null: false
      t.text :description
      t.timestamps
    end
    add_index :transactions, :created_at
  end
end
