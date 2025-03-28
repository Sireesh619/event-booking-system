module Api
  module V1
    class BookingsController < ApplicationController
      before_action :authenticate_user!
      before_action :authorize_customer, only: [:new, :show, :index]
      before_action :authorize_event_organizer, only: [:update, :destroy]

      def index
        @bookings = Booking.where(customer_id: current_user.id)
        render json: @bookings, status: :ok
      end

      def new
        @booking = Booking.new
      end

      def create
        @event = Event.find_by(id: params[:booking][:event_id])
      
        if @event.tickets_available < params[:booking][:number_of_tickets].to_i
          render json: { error: 'Not enough tickets available' }, status: :unprocessable_entity
          return
        end
      
        @booking = Booking.build(booking_params)
        @booking.number_of_tickets = params[:booking][:number_of_tickets]
        @booking.customer_id = Customer.find_by(email: current_user.email).id
        @booking.event_id = @event.id
      
        ActiveRecord::Base.transaction do
          if @booking.save
            @event.update!(tickets_available: @event.tickets_available - @booking.number_of_tickets.to_i)
            redirect_to bookings_path, notice: "Booking successfully created."
          else
            render :new, notice: @booking.errors.full_messages, status: :unprocessable_entity
          end
        end
      rescue ActiveRecord::RecordInvalid
        render json: { error: 'Failed to create booking or update ticket availability' }, status: :unprocessable_entity
      end

      def update
        @booking = current_user.bookings.find_by(id: params[:id])

        if @booking.nil?
          render json: { error: 'Booking not found or not authorized' }, status: :not_found
        elsif @booking.update(booking_params)
          render json: @booking, status: :ok
        else
          render json: { errors: @booking.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        @booking = current_user.bookings.find_by(id: params[:id])

        if @booking.nil?
          render json: { error: 'Booking not found or not authorized' }, status: :not_found
        elsif @booking.destroy
          render json: { message: 'Booking successfully deleted' }, status: :ok
        else
          render json: { error: 'Failed to delete the booking' }, status: :unprocessable_entity
        end
      end

      def show
        @bookings = current_user.bookings

        if @bookings.empty?
          render json: { error: 'No bookings found for the current user' }, status: :not_found
        else
          render json: @bookings, status: :ok
        end
      end

      private

      def booking_params
        params.require(:booking).permit(:event_id, :customer_id, :ticket_id, :number_of_tickets)
      end
    end
  end
end