class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_one :customer, dependent: :destroy
  has_one :event_organizer, dependent: :destroy

  before_create :generate_auth_token
  after_create :create_associated_record

  validates :role, inclusion: { in: %w[Customer Event_Organizer] }

  def generate_auth_token
    self.auth_token = SecureRandom.hex(20) # Generates a random 40-character token
  end

  private

  def create_associated_record
    if role == 'Customer'
      Customer.create!(user_id: id, name: email.split('@').first, email: email)
    elsif role == 'Event_Organizer'
      EventOrganizer.create!(user_id: id, name: email.split('@').first, email: email)
    end
  end
end