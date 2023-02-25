# frozen_string_literal: true

class Dinosaur < ApplicationRecord
  belongs_to :cage, inverse_of: :dinosaurs, optional: true
  validates :name, presence: true
  validates :species, presence: true
  enum species: { "Tyrannosaurus" => 0, "Velociraptor" => 1, "Spinosaurus" => 2, "Megalosaurus" => 3,
                  "Brachiosaurus" => 4, "Stegosaurus" => 5, "Ankylosaurus" => 6, "Triceratops" => 7 }

  def carnivore?
    %w[Tyrannosaurus Velociraptor Spinosaurus Megalosaurus].include?(species)
  end

  def herbivore?
    %w[Brachiosaurus Stegosaurus Ankylosaurus Triceratops].include?(species)
  end
end
