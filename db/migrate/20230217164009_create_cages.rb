# frozen_string_literal: true

class CreateCages < ActiveRecord::Migration[6.1]
  def up
    create_table :cages, &:timestamps
  end

  def down
    drop_table :cages
  end
end
