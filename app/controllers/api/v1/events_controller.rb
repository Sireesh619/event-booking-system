module Api
  module V1
    class EventsController < ApplicationController
      before_action :authenticate_user!
      before_action :authorize_event_organizer, only: [:create, :edit, :destroy]
      before_action :authorize_customer, only: [:index]
      before_action :fetch_event, only: [:show, :edit, :destroy]

      def index
        @events = Event.all
        render json: @events, status: :ok
      end

      def new
        @event = Event.new
      end

      def create
        @event = Event.build(event_params)
        @event.event_organizer_id = EventOrganizer.find_by(email: current_user.email).id

        if @event.save
          redirect_to root_path, notice: 'Event was successfully created.'
        else
          render :new,notice: @event.errors.full_messages
        end
      end

      def edit
        if @event.nil?
          render json: { error: 'Event not found or not authorized' }, status: :not_found
        else
          render :edit
        end
      end
      
      def update
        if @event.nil?
          render json: { error: 'Event not found or not authorized' }, status: :not_found
        elsif @event.update(event_params)
          render json: { message: 'Event was successfully updated', event: @event }, status: :ok
        else
          render json: { error: @event.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def show
        if @event.nil?
          render json: { error: 'Event not found or not authorized' }, status: :not_found
        else
          render json: @event, status: :ok
        end
      end

      def destroy
        if @event.nil?
          render json: { error: 'Event not found or not authorized' }, status: :not_found
        elsif @event.destroy
          render home_path, notice: 'Event was successfully deleted.'
        else
          render json: { error: 'Failed to delete the event' }, status: :unprocessable_entity
        end
      end

      private

      def event_params
        params.require(:event).permit(:id, :name, :date, :venue, :event_organizer_id)
      end

      def fetch_event
        @event = Event.find_by(id: params[:id])
        if @event.nil?
          render json: { error: 'Event not found' }, status: :not_found
        end
      end
      
    end
  end
end