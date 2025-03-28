class AddUserIdToEventOrganizers < ActiveRecord::Migration[7.1]
  def change
    add_reference :event_organizers, :user, foreign_key: true
  end
end
