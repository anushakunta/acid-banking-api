class User < ApplicationRecord
  has_secure_password

  enum role: { member: 0, admin: 1 }

  has_many :accounts, dependent: :destroy
  validates :email, presence: true, uniqueness: true
end
