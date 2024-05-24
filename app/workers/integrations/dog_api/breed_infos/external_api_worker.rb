class Integrations::DogApi::BreedInfos::ExternalApiWorker
  include Sidekiq::Worker

  def perform_sync(breed_name, pet_id)
    response = fetch_breed_info(breed_name)
    save_breed_info(response, pet_id)
  end

  private

  def fetch_breed_info(breed_name)
    response = HTTParty.get("https://dogapi.dog/api/v2/breeds")
    breed_data = JSON.parse(response.body)['data'].first || {}
    {
      name: breed_data['name'],
      description: breed_data['description']
    }
  end

  def save_breed_info(breed_info, pet_id)
    pet = Pet.find_by(id: pet_id)
    pet.update(breed_info_temp_name: breed_info[:name], breed_info_temp_description: breed_info[:description]) if pet
  end
end


