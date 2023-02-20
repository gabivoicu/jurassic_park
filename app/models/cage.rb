# frozen_string_literal: true

class Cage < ApplicationRecord
  has_many :dinosaurs, dependent: :nullify
end
