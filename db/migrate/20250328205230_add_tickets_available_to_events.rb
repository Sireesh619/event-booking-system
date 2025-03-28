class AddTicketsAvailableToEvents < ActiveRecord::Migration[7.1]
  def change
    add_column :events, :tickets_available, :integer
  end
end
