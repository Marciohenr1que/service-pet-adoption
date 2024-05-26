
require 'rails_helper'
RSpec.describe Integrations::PetsIntegration::PetService, type: :service do
  let!(:pet) { create(:pet) }

  describe '.fetch_all' do
    it 'returns all pets' do
      expect(described_class.fetch_all).to include(pet)
    end
  end

  describe '.find' do
    it 'finds a pet by id' do
      expect(described_class.find(pet.id)).to eq(pet)
    end
  end

  describe '.create' do
    context 'with valid params' do
      let(:valid_params) { attributes_for(:pet) }

      it 'creates a new pet' do
        result = described_class.create(valid_params)
        expect(result[:success]).to be_truthy
        expect(result[:pet].name).to eq(valid_params[:name])
      end
    end

    context 'with invalid params' do
      let(:invalid_params) { { name: '', pet_type: '', weight: '' } }

      it 'returns errors' do
        result = described_class.create(invalid_params)
        expect(result[:success]).to be_falsey
        expect(result[:errors]).not_to be_empty
      end
    end
  end

  describe '.update_weight' do
    it 'updates the pet weight' do
      new_weight = 30.0
      result = described_class.update_weight(pet, new_weight)
      expect(result[:success]).to be_truthy
      expect(result[:pet].weight).to eq(new_weight)
    end
  end

  describe '.destroy' do
    it 'destroys the pet' do
      expect { described_class.destroy(pet) }.to change(Pet, :count).by(-1)
    end
  end

  describe '.fetch_breed_info' do
    let(:breed_info) { create(:breed_info, name: 'Labrador') }

    it 'fetches breed info by breed name' do
      expect(described_class.fetch_breed_info('Labrador')).to eq(breed_info)
    end
  end
end

