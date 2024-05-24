require 'net/http'
class PetsService
  def self.get_breed_info(breed_name)
    uri = URI("https://dogapi.dog/api/v2/breeds")
    response = Net::HTTP.get_response(uri)

    # Adicione instrução de depuração para verificar a resposta da API
    puts "API Response: #{response.body}"
    Rails.logger.debug("API Response: #{response.body}")

    if response.is_a?(Net::HTTPSuccess)
      breeds = JSON.parse(response.body)["data"]
      breed_info = breeds.find { |breed| breed["attributes"]["name"] == breed_name }

      # Adicione instrução de depuração para verificar as informações da raça encontrada
      puts "Breed Info: #{breed_info}"
      Rails.logger.debug("Breed Info: #{breed_info}")

      return breed_info["attributes"] if breed_info

      Rails.logger.error("Breed '#{breed_name}' not found in the external API.")
      nil

    else
      Rails.logger.error("Failed to fetch data from external API. HTTP Status Code: #{response.code}")
      nil
    end
  rescue StandardError => e
    Rails.logger.error("Failed to fetch data from external API: #{e.message}")
    nil
  end

  def self.all_pets_with_details
    pets = PetRepository.all
    pets.each { |pet| add_breed_info(pet) }
    pets
  end

  def self.pet_with_details(pet)
    add_breed_info(pet)
    pet
  end
end
