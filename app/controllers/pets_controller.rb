
class PetsController < ApplicationController
  before_action :set_pet, only: [:update, :destroy, :update_weight, :show]

  def index
    pets = PetsService.all_pets_with_details
    render json: pets, each_serializer: PetSerializer
  end

  def show
    pet = PetsService.pet_with_details(@pet)
    render json: pet, serializer: PetSerializer
  end

  def create
    @pet = Pet.new(pet_params)

    if @pet.save
      pet = PetsService.pet_with_details(@pet)
      render json: pet, serializer: PetSerializer, status: :created
    else
      render json: @pet.errors, status: :unprocessable_entity
    end
  end

  def update
    if @pet.update(pet_params)
      pet = PetsService.pet_with_details(@pet)
      render json: pet, serializer: PetSerializer
    else
      render json: @pet.errors, status: :unprocessable_entity
    end
  end

  def update_weight
    new_weight = params[:weight]
    if @pet.update_weight(new_weight)
      pet = PetsService.pet_with_details(@pet)
      render json: pet, serializer: PetSerializer
    else
      render json: @pet.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @pet.destroy
    render json: { message: 'Pet deleted successfully' }, status: :ok
  end

  private

  def set_pet
    @pet = Pet.find(params[:id])
  end

  def pet_params
    params.require(:pet).permit(:name, :pet_type, :breed, :weight, :owner_id)
  end
end
