class AddCountToTickets < ActiveRecord::Migration[7.1]
  def change
    add_column :tickets, :count, :integer
  end
end
