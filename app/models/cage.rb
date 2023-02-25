# frozen_string_literal: true

class Cage < ApplicationRecord
  has_many :dinosaurs, dependent: :nullify

  HERBIVORE_ERROR_MESSAGE = "Herbivore dinosaurs can only be kept with other herbivores."
  CARNIVORE_ERROR_MESSAGE = "Carnivore dinosaurs can only be kept with their own species."

  def self.create_new!(params)
    ActiveRecord::Base.transaction do
      cage = create!
      cage.add_dinosaurs(params[:dinosaurs])
    end
  end

  def add_dinosaurs(dinosaur_ids)
    dinosaurs = Dinosaur.find(dinosaur_ids)
    dino = dinosaurs.first

    if dino.herbivore?
      unless dinosaurs.all?(&:herbivore?)
        raise ArgumentError,
              HERBIVORE_ERROR_MESSAGE
      end
    else
      raise ArgumentError, CARNIVORE_ERROR_MESSAGE unless dinosaurs.all? do |d|
                                                            d.species == dino.species
                                                          end
    end

    dinosaurs << dinosaurs
  end

  def dinosaur_count
    dinosaurs.count
  end
end
