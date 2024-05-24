class PetsController < ApplicationController
  before_action :set_pet, only: [:update, :destroy, :update_weight, :show]

  def index
    pets = PetsService.all_pets_with_details
    render json: pets, each_serializer: PetSerializer
  end

  def show
    @pet = Pet.find(params[:id])
    breed_info = PetsService.get_breed_info(@pet.breed)

    if breed_info && !breed_info.empty? # Verifica se breed_info não é nulo e não está vazio
      @pet.breed_info_temp = breed_info # Armazena temporariamente as informações da raça no objeto @pet
      render json: @pet
    else
      render json: { error: "Failed to fetch or empty breed information for pet's breed" }, status: :unprocessable_entity
    end
  end

  def create
    @pet = PetRepository.create(pet_params)
    if @pet.save
      render json: @pet, serializer: PetSerializer, status: :created
    else
      render json: { errors: @pet.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if PetRepository.update(@pet, pet_params)
      pet = PetsService.pet_with_details(@pet)
      render json: pet, serializer: DetailedPetSerializer
    else
      render json: { errors: @pet.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update_weight
    new_weight = params.require(:weight)
    if @pet.update_weight(new_weight)
      pet = PetsService.pet_with_details(@pet)
      render json: pet, serializer: PetSerializer
    else
      render json: { errors: @pet.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    PetRepository.destroy(@pet)
    render json: { message: 'Pet deleted successfully' }, status: :ok
  end

  private

  def set_pet
    @pet = PetRepository.find(params[:id])
  end

  def pet_params
    params.require(:pet).permit(:name, :pet_type, :breed, :weight, :owner_id)
  end
end
