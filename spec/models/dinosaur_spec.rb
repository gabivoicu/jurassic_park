require "rails_helper"

RSpec.describe Dinosaur do
  context "with name field" do
    it "is not valid without a name" do
      dinosaur = described_class.create
      expect(dinosaur).not_to be_valid
    end

    it "is valid with a name" do
      dinosaur = described_class.create(name: "Dino")
      expect(dinosaur).to be_valid
    end
  end

  context "with species field" do
    it "is not valid Pachiderm species" do
      expect { described_class.create(species: "Pachiderm") }
        .to raise_error(ArgumentError)
        .with_message(/is not a valid species/)
    end

    it "is valid with Megalosaurus species" do
      dinosaur = described_class.create(name: "Dino", species: "Megalosaurus")
      expect(dinosaur).to be_valid
    end

    it "is correctly identifies carnivorous species" do
      dinosaur = described_class.create(name: "Dino", species: "Megalosaurus")
      expect(dinosaur.carnivore?).to be true
    end

    it "is correctly identifies herbivore species" do
      dinosaur = described_class.create(name: "Dino", species: "Stegosaurus")
      expect(dinosaur.herbivore?).to be true
    end
  end
end
