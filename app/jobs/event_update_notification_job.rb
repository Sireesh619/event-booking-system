class EventUpdateNotificationJob < ApplicationJob
    queue_as :default
  
    def perform(event_id)
      # Fetch the event and its associated customers
      event = Event.find(event_id)
      customers = event.tickets.includes(:customer).map(&:customer).uniq
  
      # Simulate sending email notifications
      customers.each do |customer|
        puts "A confirmation email has been sent to #{user.email} for your ticket (##{ticket.id}). Thank you for booking with us!"
      end
    end
end