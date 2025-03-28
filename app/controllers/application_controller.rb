class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  
  def authenticate_user!
    render json: { error: 'You need to sign in or sign up before continuing.' }, status: :unauthorized unless user_signed_in?
  end

  def authorize_event_organizer
    unless current_user&.role == 'Event_Organizer'
      render json: { error: 'Access denied: Only Event Organizers can perform this action' }, status: :forbidden
    end
  end

  def authorize_customer
    unless current_user&.role == 'Customer'
      render json: { error: 'Access denied: Only Customers can perform this action' }, status: :forbidden
    end
  end

  # def after_sign_in_path_for(resource)
  #   api_v1_events_path
  # end
end