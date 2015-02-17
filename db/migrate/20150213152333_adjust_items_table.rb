class AdjustItemsTable < ActiveRecord::Migration
  def change
    change_column :items, :due, :datetime
  end
end
