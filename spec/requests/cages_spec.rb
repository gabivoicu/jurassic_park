require "json"

describe "#create" do
  before do
    saura = Species.create(name: "Sauropoda", average_weight: 40_000, diet: "herbivore")
    triceratops = Species.create(name: "Triceratops", average_weight: 40_000, diet: "herbivore")
    t_rex = Species.create(name: "T-Rex", average_weight: 40_000, diet: "carnivore")
    velociraptor = Species.create(name: "Velociraptor", average_weight: 40_000, diet: "carnivore")
    Dinosaur.create(id: 1, name: "Dino 1", species: saura)
    Dinosaur.create(id: 2, name: "Dino 2", species: triceratops)
    Dinosaur.create(id: 3, name: "Dino 3", species: t_rex)
    Dinosaur.create(id: 4, name: "Dino 4", species: t_rex)
    Dinosaur.create(id: 5, name: "Dino 5", species: velociraptor)
  end

  context "with valid params: empty cage" do
    before do
      post "/api/v1/cages/", params: { cage: { max_capacity: 1500 } }
    end

    it { expect(response).to have_http_status(:created) }
    it { expect(Cage.count).to be 1 }
  end

  context "with valid params: herbivore dinosaurs" do
    before do
      post "/api/v1/cages/", params: { cage: { max_capacity: 80_000, dinosaurs: [1, 2] } }
    end

    it { expect(response).to have_http_status(:created) }
    it { expect(Cage.count).to be 1 }
  end

  context "with valid params: carnivore dinosaurs" do
    before do
      post "/api/v1/cages/", params: { cage: { max_capacity: 150_000, dinosaurs: [3, 4] } }
    end

    it { expect(response).to have_http_status(:created) }
    it { expect(Cage.count).to be 1 }
  end

  context "with invalid params: over wight capacity" do
    before do
      post "/api/v1/cages/", params: { cage: { max_capacity: 70_000, dinosaurs: [3, 4] } }
    end

    it { expect(response).to have_http_status(:bad_request) }

    it {
      expect(JSON.parse(response.body)["error"]).to eq "The total weight of the dinosaurs is higher than this cages' max capacity."
    }

    it { expect(Cage.count).to be 0 }
  end

  context "with invalid params: herbivore and carnivores" do
    before do
      post "/api/v1/cages/", params: { cage: { max_capacity: 100_000, dinosaurs: [1, 3] } }
    end

    it { expect(response).to have_http_status(:bad_request) }

    it {
      expect(JSON.parse(response.body)["error"]).to eq "Herbivore dinosaurs can only be kept with other herbivores."
    }

    it { expect(Cage.count).to be 0 }
  end

  context "with invalid params: different carnivore species" do
    before do
      post "/api/v1/cages/", params: { cage: { max_capacity: 100_000, dinosaurs: [3, 5] } }
    end

    it { expect(response).to have_http_status(:bad_request) }

    it {
      expect(JSON.parse(response.body)["error"]).to eq "Carnivore dinosaurs can only be kept with their own species."
    }

    it { expect(Cage.count).to be 0 }
  end
end

describe "#index" do
  before do
    saura = Species.create(name: "Sauropoda", average_weight: 40_000, diet: "herbivore")
    triceratops = Species.create(name: "Triceratops", average_weight: 40_000, diet: "herbivore")
    dino1 = Dinosaur.create(id: 1, name: "Dino 1", species: saura)
    dino2 = Dinosaur.create(id: 2, name: "Dino 2", species: triceratops)
    Cage.create(max_capacity: 100_000, dinosaurs: [dino1, dino2])
  end

  context "with success response" do
    before do
      get "/api/v1/cages/"
    end

    it { expect(response).to have_http_status(:ok) }
    it { expect(JSON.parse(response.body)["cages"].count).to eq 1 }

    it {
      expect(JSON.parse(response.body)["cages"][0].keys).to eq %w[id created_at updated_at max_capacity
                                                                  dinosaurs dinosaur_count]
    }

    it {
      expect(JSON.parse(response.body)["cages"][0]["dinosaur_count"]).to be 2
    }
  end
end

describe "#update" do
  before do
    saura = Species.create(name: "Sauropoda", average_weight: 40_000, diet: "herbivore")
    triceratops = Species.create(name: "Triceratops", average_weight: 40_000, diet: "herbivore")
    dino1 = Dinosaur.create(id: 1, name: "Dino 1", species: saura)
    Dinosaur.create(id: 2, name: "Dino 2", species: triceratops)
    Cage.create(id: 1, max_capacity: 100_000, dinosaurs: [dino1])
  end

  context "with max_capacity change" do
    before do
      put "/api/v1/cages/1/", params: { cage: { max_capacity: "50000" } }
    end

    it { expect(response).to have_http_status(:ok) }
    it { expect(Cage.find(1).max_capacity).to eq 50_000 }
  end

  context "with dinosaurs change" do
    before do
      put "/api/v1/cages/1/", params: { cage: { dinosaurs: [1, 2] } }
    end

    it { expect(response).to have_http_status(:ok) }
    it { expect(Cage.find(1).dinosaur_count).to eq 2 }
  end
end
