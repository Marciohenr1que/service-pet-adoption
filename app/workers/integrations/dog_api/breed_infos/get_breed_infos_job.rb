require 'redis'

module Integrations
  module DogApi
    module BreedInfos
      class GetBreedInfosJob
        include Sidekiq::Worker

        REDIS_NAMESPACE = 'dog_breeds'

        def perform(breed_name)
          redis = Redis.new(url: ENV['REDIS_URL'])
          logger = Rails.logger

          # raça utilizando o serviço BreedInfoService
          breed_info = BreedInfoService.get_breed_info(breed_name)

          if breed_info.present?
            # Define a chave no Redis
            breed_key = "#{REDIS_NAMESPACE}:#{breed_info[:breed]}"

            # Armazena as informações da raça no Redis usando um hash
            redis.hmset(
              breed_key,
              'name', breed_info[:breed],
              'description', breed_info[:description],
              'life_span', breed_info[:life_span],
              'male_weight', breed_info[:male_weight],
              'female_weight', breed_info[:female_weight]
            )
          else
            # Loga
            logger.error "Failed to fetch breed info for #{breed_name}"
          end
        rescue StandardError => e
          logger.error "An error occurred: #{e.message}"
        end
      end
    end
  end
end
