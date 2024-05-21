
class PetsService
  def self.all_pets_with_details
    pets = PetRepository.all
    pets.each { |pet| add_breed_info(pet) }
    pets
  end

  
  def self.pet_with_details(pet)
    add_breed_info(pet)
    pet
  end

  private

  def self.add_breed_info(pet)
    breed_info = Integrations::DogApi::BreedInfoService.get_breed_info(pet.breed)
    pet.define_singleton_method(:breed_info) { breed_info || {} }
  end
end
