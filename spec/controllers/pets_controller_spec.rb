require 'rails_helper'

RSpec.describe PetsController, type: :controller do
  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new pet' do
        owner = Owner.create(name: 'marcio', email: 'marcio@example.com', phone: '1234567890')
        post :create, params: { pet: { name: 'Fluffy', pet_type: 'Dog', breed: 'Poodle', weight: 20, owner_id: owner.id } }
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      it 'returns unprocessable_entity status' do
        post :create, params: { pet: { name: 'nina', pet_type: 'Dog', breed: 'Poodle', weight: 20 } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
    describe 'GET #index' do
      it 'returns a success response' do
        get :index
        expect(response).to be_successful
      end
    end
    describe 'GET #show' do
      it 'returns a success response' do
        owner = Owner.create(name: 'marcio', email: 'marcio@example.com', phone: '1234567890')
        pet = Pet.create(name: 'nina', pet_type: 'Dog', breed: 'Poodle', weight: 20, owner_id: owner.id)
        get :show, params: { id: pet.id }
        expect(response).to be_successful
      end
    end
    describe 'PUT #update' do
      it 'updates the pet' do
        owner = Owner.create(name: 'marcio', email: 'john@example.com', phone: '1234567890')
        pet = Pet.create(name: 'renato', pet_type: 'Dog', breed: 'Poodle', weight: 20, owner_id: owner.id)
        put :update, params: { id: pet.id, pet: { name: 'nina' } }
        expect(pet.reload.name).to eq('nina')
      end
    end

    describe 'DELETE #destroy' do
      it 'destroys the pet' do
        owner = Owner.create(name: 'marcio', email: 'marcio@example.com', phone: '1234567890')
        pet = Pet.create(name: 'nina', pet_type: 'Dog', breed: 'Poodle', weight: 20, owner_id: owner.id)
        delete :destroy, params: { id: pet.id }
        expect { pet.reload }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
