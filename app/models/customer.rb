class Customer < ApplicationRecord
    belongs_to :user
    has_many :bookings, dependent: :destroy
  
    validates :name, :email, presence: true
    validates :email, uniqueness: true
    validate :user_id, :phone_number

    def user_id
      user.id
    end

    def phone_number
      user.phone_number
    end
  end