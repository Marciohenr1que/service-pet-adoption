class ExternalApiWorker
  include Sidekiq::Worker

  def perform(breed, pet_id)
    breed_info = BreedInfoService.get_breed_info(breed)
    if breed_info
      pet = Pet.find(pet_id)
      pet.pet_detail.update_attributes(breed_info)

      PetsController.renderer.new.render(json: pet, serializer: DetailedPetSerializer)
    else
      Rails.logger.error("Breed info not found for breed: #{breed}")
    end
  end
end
