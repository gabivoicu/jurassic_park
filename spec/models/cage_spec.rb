require "rails_helper"

RSpec.describe Cage do
  context "with 2 or more dinosaurs" do
    it "orders them chronologically" do
      cage = described_class.create!
      dinosaur1 = cage.dinosaurs.create!(name: "Dino 1", species: "Megalosaurus")
      dinosaur2 = cage.dinosaurs.create!(name: "Dino 2", species: "Megalosaurus")
      expect(cage.reload.dinosaurs).to eq([dinosaur1, dinosaur2])
    end
  end
end
