class User < ApplicationRecord
    has_secure_password
  
    validates :email, presence: true, uniqueness: true
    validates :first_name, :last_name, :phone_number, :location, presence: true
    validates :password, presence: true, length: { minimum: 6 }
  end
  