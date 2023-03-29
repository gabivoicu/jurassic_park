# frozen_string_literal: true

class Species < ApplicationRecord
  has_many :dinosaurs, dependent: :nullify

  validates :average_weight, presence: true
  validates :diet, presence: true
  validates :name, presence: true

  enum diet: { "carnivore" => 0, "herbivore" => 1 }
end
