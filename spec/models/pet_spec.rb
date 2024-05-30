# == Schema Information
#
# Table name: pets
#
#  id         :bigint           not null, primary key
#  breed      :string
#  name       :string
#  pet_type   :string
#  weight     :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  owner_id   :bigint           not null
#
# Indexes
#
#  index_pets_on_owner_id  (owner_id)
#
# Foreign Keys
#
#  fk_rails_...  (owner_id => owners.id)
#
require 'rails_helper'

RSpec.describe Pet, type: :model do
  let(:owner) { Owner.create(name: 'marcio', email: 'marcio@example.com', phone: '1234567890') }
  let(:breed_info) { Breed.create(name: 'Poodle', description: 'A small dog breed') }

  describe 'associations' do
    it { should belong_to(:owner) }
    it { should belong_to(:breed_info).optional }
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      pet = Pet.new(name: 'Fluffy', pet_type: 'Dog', breed: 'Poodle', weight: 20, owner: owner, breed_info: breed_info)
      expect(pet).to be_valid
    end

    it 'is not valid without a name' do
      pet = Pet.new(pet_type: 'Dog', breed: 'Poodle', weight: 20, owner: owner, breed_info: breed_info)
      expect(pet).not_to be_valid
    end

    it 'is not valid without a pet_type' do
      pet = Pet.new(name: 'Fluffy', breed: 'Poodle', weight: 20, owner: owner, breed_info: breed_info)
      expect(pet).not_to be_valid
    end

    it 'is not valid without a breed' do
      pet = Pet.new(name: 'Fluffy', pet_type: 'Dog', weight: 20, owner: owner, breed_info: breed_info)
      expect(pet).not_to be_valid
    end

    it 'is not valid without a weight' do
      pet = Pet.new(name: 'Fluffy', pet_type: 'Dog', breed: 'Poodle', owner: owner, breed_info: breed_info)
      expect(pet).not_to be_valid
    end

    it 'is not valid without an owner' do
      pet = Pet.new(name: 'Fluffy', pet_type: 'Dog', breed: 'Poodle', weight: 20, breed_info: breed_info)
      expect(pet).not_to be_valid
    end

    it 'is valid without a breed_info' do
      pet = Pet.new(name: 'Fluffy', pet_type: 'Dog', breed: 'Poodle', weight: 20, owner: owner)
      expect(pet).to be_valid
    end
  end
end

