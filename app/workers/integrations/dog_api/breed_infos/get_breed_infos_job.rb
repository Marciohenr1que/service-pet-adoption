require 'redis'

module Integrations
  module DogApi
    module BreedInfos
      class GetBreedInfosJob
        include Sidekiq::Worker

        REDIS_NAMESPACE = 'dog_breeds'

        def perform
          redis = Redis.new(url: 'rediss://red-cp4egei1hbls73f0gic0:XdtJb5cUIw2kQHtb0Hre6BlGutklcUC4@oregon-redis.render.com:6379')

          response = Integrations::DogApi::Client.get("/api/v2/breeds")

          return unless response.present? && response.code == 200

          breeds = JSON.parse(response.body)['data']

          breeds.each do |breed|
            breed_info = Helpers::BreedInfoHelper.parse_breed_info(breed['attributes'])

            next unless breed_info.present?

            # Cria uma chave única para cada raça
            breed_key = "#{REDIS_NAMESPACE}:#{breed_info[:breed]}"

            redis.hmset(
              breed_key,
              'name', breed_info[:breed],
              'description', breed_info[:description],
              'life_span', breed_info[:life_span],
              'male_weight', breed_info[:male_weight],
              'female_weight', breed_info[:female_weight]
            )
          rescue StandardError => e
            logger.error "Failed to process breed #{breed['attributes']['name']}: #{e.message}"
          end
        end
      end
    end
  end
end

