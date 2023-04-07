require "json"

describe "#create" do
  context "with valid params" do
    before do
      post "/api/v1/species/", params: { species: { name: "Sauropoda",
                                                    average_weight: "40000", diet: "herbivore" } }
    end

    it { expect(response).to have_http_status(:created) }
    it { expect(Species.count).to be 1 }
  end

  context "with missing average_weight param" do
    before do
      post "/api/v1/species/", params: { species: { name: "Sauropoda", diet: "herbivore" } }
    end

    it { expect(response).to have_http_status(:bad_request) }
    it { expect(JSON.parse(response.body)["error"]).to eq "Validation failed: Average weight can't be blank" }
    it { expect(Species.count).to be 0 }
  end

  context "with missing diet param" do
    before do
      post "/api/v1/species/", params: { species: { name: "Sauropoda", average_weight: "40000" } }
    end

    it { expect(response).to have_http_status(:bad_request) }
    it { expect(JSON.parse(response.body)["error"]).to eq "Validation failed: Diet can't be blank" }
    it { expect(Species.count).to be 0 }
  end

  context "with missing name param" do
    before do
      post "/api/v1/species/", params: { species: { average_weight: "40000", diet: "herbivore" } }
    end

    it { expect(response).to have_http_status(:bad_request) }
    it { expect(JSON.parse(response.body)["error"]).to eq "Validation failed: Name can't be blank" }
    it { expect(Species.count).to be 0 }
  end

  context "with invalid diet param" do
    before do
      post "/api/v1/species/", params: { species: { name: "Sauropoda",
                                                    average_weight: "40000", diet: "meat" } }
    end

    it { expect(response).to have_http_status(:bad_request) }
    it { expect(JSON.parse(response.body)["error"]).to eq "'meat' is not a valid diet" }
    it { expect(Species.count).to be 0 }
  end
end

describe "#index" do
  before do
    Species.create(name: "Sauropoda", average_weight: "40000", diet: "herbivore")
    Species.create(name: "T-Rex", average_weight: "40000", diet: "carnivore")
  end

  context "with success response" do
    before do
      get "/api/v1/species/"
    end

    it { expect(response).to have_http_status(:ok) }
    it { expect(JSON.parse(response.body)["species"].count).to eq 2 }

    it {
      expect(JSON.parse(response.body)["species"][0].keys).to eq %w[id name diet average_weight created_at updated_at]
    }
  end
end

describe "#update" do
  before do
    Species.create(id: 1, name: "T-Rex", average_weight: 40_000, diet: "carnivore")
  end

  context "with average weight change" do
    before do
      put "/api/v1/species/1/", params: { species: { average_weight: "50000" } }
    end

    it { expect(response).to have_http_status(:ok) }
    it { expect(Species.find(1).average_weight).to eq 50_000 }
  end

  context "with diet change" do
    before do
      put "/api/v1/species/1/", params: { species: { diet: "herbivore" } }
    end

    it { expect(response).to have_http_status(:ok) }
    it { expect(Species.find(1).diet).to eq "herbivore" }
  end

  context "with name change" do
    before do
      put "/api/v1/species/1/", params: { species: { name: "Sauropoda" } }
    end

    it { expect(response).to have_http_status(:ok) }
    it { expect(Species.find(1).name).to eq "Sauropoda" }
  end
end
