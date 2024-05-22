require 'redis'

module Integrations
  module DogApi
    module BreedInfos
      class GetBreedInfosJob
        include Sidekiq::Worker

        REDIS_NAMESPACE = 'dog_breeds'

        def perform
          redis = Redis.new(url: 'rediss://red-cp5nvsa1hbls73fj3ssg:9ocnNmDZK6fPz4UChUI3wfF8AukSP0oU@virginia-redis.render.com:6379')
          logger = Rails.logger # Define o objeto logger

          response = Client.get("/api/v2/breeds")

          if response.present? && response.code == 200
            breeds = JSON.parse(response.body)['data']

            breeds.each do |breed|
              begin
                breed_info = BreedInfoHelper.parse_breed_info(breed['attributes'])
                dog_api_breed_info = BreedInfoHelper.parse_breed_info(breed['attributes'])

                next unless breed_info.present?

                breed_key = "#{REDIS_NAMESPACE}:#{breed_info[:breed]}"

                redis.hmset(
                  breed_key,
                  'name', breed_info[:breed],
                  'description', breed_info[:description],
                  'life_span', dog_api_breed_info[:life_span],
                  'male_weight', dog_api_breed_info[:male_weight],
                  'female_weight', dog_api_breed_info[:female_weight]
                )
              rescue StandardError => e
                logger.error "Failed to process breed #{breed['attributes']['name']}: #{e.message}"
              end
            end
          else
            logger.error "Failed to fetch dog breeds: #{response.code}"
          end
        end
      end
    end
  end
end
