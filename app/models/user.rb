class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true,
                    uniqueness: true,
                    length: { minimum: 5 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }

  validates :password_digest, presence: true
end
