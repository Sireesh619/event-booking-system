class TicketsController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_event_organizer, only: [:new, :create, :edit, :update, :destroy]
  
    def index
      @tickets = Ticket.accessible_by(current_user)
    end
  
    def create
      @ticket = Ticket.new(ticket_params)
  
      if @ticket.save
        # Enqueue the Sidekiq job
        TicketConfirmationJob.perform_later(@ticket.id)
        redirect_to tickets_path, notice: 'Ticket was successfully created.'
      else
        render :new
      end
    end

    private
  
    def authorize_event_organizer
      redirect_to root_path, alert: 'Access denied!' unless current_user&.role == 'Event_Organizer'
    end

    def ticket_params
      params.require(:ticket).permit(:ticket_type, :price, :availability, :user_id)
    end
  end