# frozen_string_literal: true

class Dinosaur < ApplicationRecord
  belongs_to :cage, inverse_of: :dinosaurs, optional: true
  belongs_to :species, inverse_of: :dinosaurs, optional: true

  validates :name, presence: true

  delegate :average_weight, to: :species
  delegate :herbivore?, to: :species
  delegate :herbivore?, to: :species
end
