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
end
