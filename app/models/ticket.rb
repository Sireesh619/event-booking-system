class Ticket < ApplicationRecord
  belongs_to :event
  has_many :bookings, dependent: :destroy

  validates :ticket_type, :price, :availability, presence: true
  validates :tickets_available, numericality: { greater_than_or_equal_to: 0 }

  before_save :update_availability

  def self.accessible_by(user)
    if current_user&.role == 'Event_Organizer'
      all
    else
      where(availability: true)
    end
  end

  def tickets_available
    if tickets_available > 0
      availability = true
    else
      availability = false
    end
  end
end