require "json"

describe "#create" do
  context "with valid params" do
    before do
      post "/api/v1/dinosaurs/", params: { dinosaur: { name: "Dino 1" } }
    end

    it { expect(response).to have_http_status(:created) }
    it { expect(Dinosaur.count).to be 1 }
  end

  context "with missing name param" do
    before do
      post "/api/v1/dinosaurs/", params: { dinosaur: { species_id: 1 } }
    end

    it { expect(response).to have_http_status(:bad_request) }
    it { expect(JSON.parse(response.body)["error"]).to eq "Validation failed: Name can't be blank" }
    it { expect(Dinosaur.count).to be 0 }
  end
end

describe "#index" do
  before do
    saura = Species.create(id: 1, name: "Sauropoda", average_weight: "40000", diet: "herbivore")
    Dinosaur.create(name: "Dino", species: saura)
    Dinosaur.create(name: "Dino 2", species: saura)
  end

  context "with success response" do
    before do
      get "/api/v1/dinosaurs/"
    end

    it { expect(response).to have_http_status(:ok) }
    it { expect(JSON.parse(response.body)["dinosaurs"].count).to eq 2 }

    it {
      expect(JSON.parse(response.body)["dinosaurs"][0].keys).to eq %w[id name cage_id created_at
                                                                      updated_at species_id]
    }
  end
end

describe "#update" do
  before do
    Species.create(id: 1, name: "T-Rex", average_weight: 40_000, diet: "carnivore")
    saura = Species.create(id: 2, name: "Sauropoda", average_weight: 40_000, diet: "herbivore")
    Dinosaur.create(id: 1, name: "Dino", species: saura)
  end

  context "with name change" do
    before do
      put "/api/v1/dinosaurs/1/", params: { dinosaur: { name: "Mighty Dino" } }
    end

    it { expect(response).to have_http_status(:ok) }
    it { expect(Dinosaur.find(1).name).to eq "Mighty Dino" }
  end

  context "with species change" do
    before do
      put "/api/v1/dinosaurs/1/", params: { dinosaur: { species_id: 1 } }
    end

    it { expect(response).to have_http_status(:ok) }
    it { expect(Dinosaur.find(1).species.name).to eq "T-Rex" }
  end
end
