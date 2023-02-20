# frozen_string_literal: true

class Dinosaur < ApplicationRecord
  belongs_to :cage, inverse_of: :dinosaurs, optional: true
end
