class User < ApplicationRecord
  has_secure_password
  validates_presence_of :name, :password
  validates_uniqueness_of :email

  has_many :favorites
end