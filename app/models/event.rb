class Event < ApplicationRecord
  belongs_to :event_organizer
  has_many :bookings, dependent: :destroy
  has_many :customers, through: :tickets

  validate :event_organizer_must_be_valid

  after_update :notify_customers_of_update

  private

  def event_organizer_must_be_valid
    binding.pry
    unless User.find_by(email: event_organizer.email)&.role == 'Event_Organizer'
      errors.add(:event_organizer, 'must be a user with the role Event_Organizer')
    end
  end

  def notify_customers_of_update
    EventUpdateNotificationJob.perform_later(self.id)
  end
end