class RemoveCountFromTickets < ActiveRecord::Migration[7.1]
  def change
    remove_column :tickets, :count, :integer
  end
end
