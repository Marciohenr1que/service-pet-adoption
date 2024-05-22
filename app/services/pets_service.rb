require 'redis'
class PetsService
  REDIS_NAMESPACE = 'dog_breeds'
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
    breed_key = "#{REDIS_NAMESPACE}:#{pet.breed}"
    redis = Redis.new(url: 'rediss://red-cp5nvsa1hbls73fj3ssg:9ocnNmDZK6fPz4UChUI3wfF8AukSP0oU@virginia-redis.render.com:6379')
    
  
    # Verifica se as informações da raça estão armazenadas no Redis
    breed_info = redis.hgetall(breed_key)
    
    # Se as informações não estiverem no Redis, busca na API externa
    if breed_info.empty?
      breed_info = Integrations::DogApi::BreedInfoService.get_breed_info(pet.breed)
      
      # Se as informações da raça estiverem disponíveis, armazena no Redis para uso futuro
      if breed_info.present?
        redis.hmset(
          breed_key,
          'name', breed_info[:breed],
          'description', breed_info[:description],
          'life_span', breed_info[:life_span],
          'male_weight', breed_info[:male_weight],
          'female_weight', breed_info[:female_weight]
        )
      end
    end
  
    # Define o método breed_info no objeto pet
    pet.define_singleton_method(:breed_info) { breed_info || {} }
  end
end
