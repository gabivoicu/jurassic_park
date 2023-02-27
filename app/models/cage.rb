# frozen_string_literal: true

class Cage < ApplicationRecord
  has_many :dinosaurs, dependent: :nullify

  HERBIVORE_ERROR_MESSAGE = "Herbivore dinosaurs can only be kept with other herbivores."
  CARNIVORE_ERROR_MESSAGE = "Carnivore dinosaurs can only be kept with their own species."
  MAX_CAPACITY_ERROR_MESSAGE = "The number of dinosaurs is higher than this cages' max capacity."

  def self.create_new!(params)
    ActiveRecord::Base.transaction do
      cage = create!(max_capacity: params[:max_capacity])
      cage.add_dinosaurs(params[:dinosaurs])
    end
  end

  # Sets the dinosaurs that belong to a cage. Each time, this method will set all of the dinosaurs so it requires
  # a complete current list be passed from client, not a "delta" (adding or removing a single dinosaur from cage)
  def add_dinosaurs(dinosaur_ids)
    raise ArgumentError, MAX_CAPACITY_ERROR_MESSAGE if dinosaur_ids.length > max_capacity

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

    self.dinosaurs << dinosaurs
  end

  def dinosaur_count
    dinosaurs.count
  end
end
