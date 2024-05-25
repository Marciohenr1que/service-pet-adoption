module Integrations
    module PetsIntegration

class PetService
    def self.fetch_all
      PetRepository.all
    end
  
    def self.find(id)
      PetRepository.find(id)
    end
  
    def self.create(params)
      pet = PetRepository.create(params)
      if pet.save
        { success: true, pet: pet }
      else
        { success: false, errors: pet.errors.full_messages }
      end
    end
  
    def self.update_weight(pet, weight)
      if PetRepository.update(pet, weight: weight)
        { success: true, pet: pet }
      else
        { success: false, errors: pet.errors.full_messages }
      end
    end
  
    def self.destroy(pet)
      PetRepository.destroy(pet)
    end
  
    def self.fetch_breed_info(breed_name)
      Breed.find_by(name: breed_name)
    end
  end

end

end