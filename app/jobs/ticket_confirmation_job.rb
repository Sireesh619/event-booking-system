class TicketConfirmationJob < ApplicationJob
  queue_as :default

  def perform(ticket_id)
    ticket = Ticket.find(ticket_id)
    user = ticket.user

    # Simulate sending an email
    puts "Notification email will be sent to #{customer.email} regarding updates to the event: #{event.name}."
  end
end