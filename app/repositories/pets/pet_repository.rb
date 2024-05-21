class PetRepository
    def self.all
      Pet.all
    end
  
    def self.find(id)
      Pet.find(id)
    end
  
    def self.create(params)
      Pet.new(params)
    end
  
    def self.update(pet, params)
      pet.update(params)
    end
  
    def self.destroy(pet)
      pet.destroy
    end
  end