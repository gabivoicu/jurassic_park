class Api::V1::SpeciesController < ApplicationController
  def index
    species = Species.all.as_json

    render json: { species: }, formats: :json
  end

  def create
    species = Species.new(species_params)

    species.save!
    render json: { message: "Species created successfully" }, formats: :json, status: :created
  rescue StandardError => e
    render json: { error: e.message }, status: :bad_request
  end

  def update
    species = Species.find(params[:id])

    species.update!(species_params)
    render json: { message: "Species updated successfully" }, formats: :json, status: :ok
  rescue StandardError => e
    render json: { error: e.message }, status: :bad_request
  end

  private

  def species_params
    params.require(:species).permit(:average_weight, :diet, :name)
  end
end
