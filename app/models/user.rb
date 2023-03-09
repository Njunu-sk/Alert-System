class User < ApplicationRecord
  has_secure_password

  has_many :alerts

  validates_presence_of :name, :email, :password_digest
end
