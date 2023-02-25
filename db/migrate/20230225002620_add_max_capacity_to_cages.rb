class AddMaxCapacityToCages < ActiveRecord::Migration[6.1]
  def up
    add_column :cages, :max_capacity, :integer
  end

  def down
    remove_column :cages, :max_capacity
  end
end
