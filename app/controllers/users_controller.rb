class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_event_organizer, only: [:create, :update, :destroy]
  
    private
  
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :role) # Ensure :role is included here
    end
  
    def authorize_event_organizer
      unless current_user.role == 'Event_Organizer'
        render json: { error: 'Access denied: Only Event Organizers can perform this action' }, status: :forbidden
      end
    end
  end