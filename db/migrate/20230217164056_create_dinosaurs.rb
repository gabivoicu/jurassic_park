# frozen_string_literal: true

class CreateDinosaurs < ActiveRecord::Migration[6.1]
  def up
    create_table :dinosaurs do |t|
      t.string :name
      t.string :species
      t.belongs_to :cage, null: true, foreign_key: true
      t.timestamps
    end
  end

  def down
    drop_table :dinosaurs
  end
end
