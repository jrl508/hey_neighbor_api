class User < ApplicationRecord
    has_secure_password
  
    validates :email, presence: true, uniqueness: true
    validates :first_name, :last_name, presence: true
    validates :password, presence: true, length: { minimum: 6 }, if: :password_required?
    validates :phone_number, allow_nil:true, allow_blank:true , uniqueness:true

    private

    def password_required?
      password.present? || new_record?
    end
  end
  