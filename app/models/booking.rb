class Booking < ApplicationRecord
  belongs_to :ticket
  belongs_to :customer

  before_create :reduce_ticket_count

  private

  def reduce_ticket_count
    unless ticket.book_ticket
      errors.add(:base, 'Booking cannot be completed as the ticket is sold out')
      throw :abort
    end
  end
end