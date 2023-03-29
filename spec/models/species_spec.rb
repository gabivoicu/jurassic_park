require "rails_helper"

RSpec.describe Species do
  context "with name field" do
    it "is not valid without average weight" do
      species = described_class.create(diet: 0, name: "T-Rex")
      expect(species).not_to be_valid
    end

    it "is not valid without diet" do
      species = described_class.create(average_weight: 745.5, name: "T-Rex")
      expect(species).not_to be_valid
    end

    it "is not valid without name" do
      species = described_class.create(average_weight: 745.5, diet: 0)
      expect(species).not_to be_valid
    end

    it "is valid with all required fields" do
      species = described_class.create(average_weight: 745.5, diet: 0, name: "T-Rex")
      expect(species).to be_valid
    end
  end
end
