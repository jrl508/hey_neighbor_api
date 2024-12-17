class User < ApplicationRecord
    include Rails.application.routes.url_helpers
    
    has_secure_password
  
    validates :email, presence: true, uniqueness: true
    validates :first_name, :last_name, presence: true
    validates :password, presence: true, length: { minimum: 6 }, if: :password_required?
    validates :phone_number, allow_nil:true, allow_blank:true , uniqueness:true

    has_one_attached :profile_image
 
    def profile_image_url
      if profile_image.attached?
        Rails.application.routes.url_helpers.rails_blob_url(profile_image, only_path: true)
      else
        "../assets/images/profiledefault.svg"
      end
    end

    private

    def password_required?
      password.present? || new_record?
    end

  end
  