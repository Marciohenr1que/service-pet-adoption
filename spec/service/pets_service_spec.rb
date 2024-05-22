require 'rails_helper'

RSpec.describe PetsService, type: :service do
  describe '.add_breed_info' do
    let(:pet) { instance_double('Pet', breed: 'Labrador') }

    context 'when breed information is stored in Redis' do
      before do
        redis = Redis.new(url: 'rediss://red-cp5nvsa1hbls73fj3ssg:9ocnNmDZK6fPz4UChUI3wfF8AukSP0oU@virginia-redis.render.com:6379')
        breed_key = "dog_breeds:Labrador"
        redis.hmset(breed_key, 'name', 'Labrador', 'description', 'Friendly and outgoing', 'life_span', '10-12 years', 'male_weight', '65-80 pounds', 'female_weight', '55-70 pounds')
      end

      it 'returns breed information from Redis' do
        puts "Starting test to ensure breed information is stored in Redis..."
        PetsService.add_breed_info(pet)
        puts "Pet breed info after adding breed info: #{pet.breed_info}"
        expect(pet).to respond_to(:breed_info)
        expect(pet.breed_info).to include(
          'name' => 'Labrador',
          'description' => 'Friendly and outgoing',
          'life_span' => '10-12 years',
          'male_weight' => '65-80 pounds',
          'female_weight' => '55-70 pounds'
        )
      end
    end

    context 'when breed information is not stored in Redis' do
      before do
        allow(Integrations::DogApi::BreedInfoService).to receive(:get_breed_info).with('Labrador').and_return({
          breed: 'Labrador',
          description: 'Friendly and outgoing',
          life_span: '10-12 years',
          male_weight: '65-80 pounds',
          female_weight: '55-70 pounds'
        })
      end

      it 'fetches breed information from the external API' do
        puts "Starting test when breed information is not stored in Redis..."
        PetsService.add_breed_info(pet)
        puts "Pet breed info after adding breed info: #{pet.breed_info}"
        expect(pet).to respond_to(:breed_info)
        expect(pet.breed_info).to include(
          'name' => 'Labrador',
          'description' => 'Friendly and outgoing',
          'life_span' => '10-12 years',
          'male_weight' => '65-80 pounds',
          'female_weight' => '55-70 pounds'
        )
      end

      it 'stores breed information in Redis' do
        puts "Starting test to ensure breed information is stored in Redis..."
        PetsService.add_breed_info(pet)
        redis = Redis.new(url: 'rediss://red-cp5nvsa1hbls73fj3ssg:9ocnNmDZK6fPz4UChUI3wfF8AukSP0oU@virginia-redis.render.com:6379')
        breed_key = "dog_breeds:Labrador"
        expect(redis.hgetall(breed_key)).to include(
          'name' => 'Labrador',
          'description' => 'Friendly and outgoing',
          'life_span' => '10-12 years',
          'male_weight' => '65-80 pounds',
          'female_weight' => '55-70 pounds'
        )
      end
    end
  end
end
