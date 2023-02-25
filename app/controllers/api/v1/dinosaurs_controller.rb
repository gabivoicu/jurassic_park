class Api::V1::DinosaursController < ApplicationController
  def show
    dinosaurs = Dinosaur.all.as_json

    render json: { dinosaurs: }, formats: :json
  end

  def create
    dinosaur = Dinosaur.new(dinosaur_params)

    dinosaur.save!
    render json: { message: "Dinosaur created successfully" }, formats: :json, status: :created
  rescue StandardError => e
    render json: { error: e.message }, status: :bad_request
  end

  def update
    dinosaur = Dinosaur.find(params[:id])

    dinosaur.update!(dinosaur_params)
    render json: { message: "Dinosaur updated successfully" }, formats: :json, status: :ok
  rescue StandardError => e
    render json: { error: e.message }, status: :bad_request
  end

  private

  def dinosaur_params
    params.require(:dinosaur).permit(:name, :species, :cage_id)
  end
end
