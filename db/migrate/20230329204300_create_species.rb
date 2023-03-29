# frozen_string_literal: true

class CreateSpecies < ActiveRecord::Migration[6.1]
  def up
    create_table :species do |t|
      t.string :name
      t.integer :diet
      t.decimal :average_weight
      t.timestamps
    end
  end

  def down
    drop_table :species
  end
end
