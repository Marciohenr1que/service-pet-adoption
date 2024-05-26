require 'rails_helper'

RSpec.describe PetRepository, type: :repository do
  let(:owner) { Owner.create(name: 'marcio', email: 'marcio@example.com', phone: '1234567890') }

  describe '.all' do
    it 'returns all pets' do
      pet1 = Pet.create(name: 'nina', pet_type: 'Dog', breed: 'Poodle', weight: 20, owner: owner)
      pet2 = Pet.create(name: 'rex', pet_type: 'Dog', breed: 'Labrador', weight: 30, owner: owner)
      pets = PetRepository.all
      expect(pets).to include(pet1, pet2)
    end
  end

  describe '.find' do
    it 'returns the pet with the given id' do
      pet = Pet.create(name: 'nina', pet_type: 'Dog', breed: 'Poodle', weight: 20, owner: owner)
      found_pet = PetRepository.find(pet.id)
      expect(found_pet).to eq(pet)
    end
  end

  describe '.create' do
    it 'creates a new pet' do
      pet_params = { name: 'Fluffy', pet_type: 'Dog', breed: 'Poodle', weight: 20, owner: owner }
      new_pet = PetRepository.create(pet_params)
      expect(new_pet).to be_a(Pet)
      expect(new_pet.name).to eq('Fluffy')
    end
  end

  describe '.update' do
    it 'updates the pet with the given parameters' do
      pet = Pet.create(name: 'nina', pet_type: 'Dog', breed: 'Poodle', weight: 20, owner: owner)
      updated_params = { weight: 25 }
      PetRepository.update(pet, updated_params)
      expect(pet.reload.weight).to eq(25)
    end
  end

  describe '.destroy' do
    it 'destroys the pet' do
      pet = Pet.create(name: 'nina', pet_type: 'Dog', breed: 'Poodle', weight: 20, owner: owner)
      PetRepository.destroy(pet)
      expect { pet.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
