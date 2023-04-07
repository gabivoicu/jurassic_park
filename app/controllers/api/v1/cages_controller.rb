class Api::V1::CagesController < ApplicationController
  def index
    cages = Cage.all.as_json(methods: [:dinosaurs, :dinosaur_count])

    render json: { cages: }, formats: :json
  end

  def create
    Cage.create_new!(cage_params)
    render json: { message: "Cage created successfully" }, formats: :json, status: :created
  rescue StandardError => e
    render json: { error: e.message }, status: :bad_request
  end

  def update
    cage = Cage.find(params[:id])
    cage.update!(max_capacity: cage_params[:max_capacity]) if cage_params[:max_capacity].present?
    cage.add_dinosaurs(cage_params[:dinosaurs]) if cage_params[:dinosaurs].present?

    render json: { message: "Cage updated successfully" }, formats: :json, status: :ok
  rescue StandardError => e
    render json: { error: e.message }, status: :bad_request
  end

  private

  def cage_params
    params.require(:cage).permit(:max_capacity, dinosaurs: [])
  end
end
