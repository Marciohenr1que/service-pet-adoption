class PetsController < ApplicationController
  before_action :set_pet, only: [:destroy, :update, :show]

  def index
    pets = Integrations::Pets::PetService.fetch_all
    render json: pets, each_serializer: PetSerializer
  end

  def show
    breed_info = Integrations::Pets::PetService.fetch_breed_info(@pet.breed)

    if breed_info
      render json: { pet: @pet, breed_description: breed_info.description }
    else
      render json: { pet: @pet, breed_description: I18n.t('pets.messages.breed_info_missing') }
    end
  end

  def create
    result = Integrations::Pets::PetService.create(pet_params)

    if result[:success]
      render json: result[:pet], serializer: PetSerializer, status: :created
    else
      render json: { errors: result[:errors] }, status: :unprocessable_entity
    end
  end

  def update
    result = Integrations::Pets::PetService.update_weight(@pet, pet_params[:weight])

    if result[:success]
      render json: result[:pet], serializer: PetSerializer, status: :ok
    else
      render json: { errors: result[:errors] }, status: :unprocessable_entity
    end
  end

  def destroy
    Integrations::Pets::PetService.destroy(@pet)
    render json: { message: I18n.t('pets.messages.pet_deleted') }, status: :ok
  end

  private

  def set_pet
    @pet = Integrations::Pets::PetService.find(params[:id])
  end

  def pet_params
    params.require(:pet).permit(:name, :pet_type, :breed, :weight, :owner_id)
  end
end
