class User < ApplicationRecord
    has_secure_password
  
    validates :email, presence: true, uniqueness: true
    validates :first_name, :last_name, presence: true
    validates :password, presence: true, length: { minimum: 6 }
    validates :phone_number, allow_nil:true, allow_blank:true , uniqueness:true
  end
  