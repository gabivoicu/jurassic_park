# frozen_string_literal: true

class UpdateSpeciesOnDinosaur < ActiveRecord::Migration[6.1]
  def up
    remove_column :dinosaurs, :species
    add_belongs_to :dinosaurs, :species, null: true, column: :species_id
  end
  
  def down
    add_column :dinosaurs, :species, :integer
    remove_column :dinosaurs, :species_id
  end
end
