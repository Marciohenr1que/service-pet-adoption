require 'redis'

module Helpers
  class BreedInfoHelper
    REDIS_NAMESPACE = 'dog_breeds'

    def self.get_breed_info(breed_name)
      redis = Redis.new(url: 'rediss://red-cp4egei1hbls73f0gic0:XdtJb5cUIw2kQHtb0Hre6BlGutklcUC4@oregon-redis.render.com:6379')
      breed_key = "#{REDIS_NAMESPACE}:#{breed_name}"
      redis.hgetall(breed_key)
    end

    def self.parse_breed_info(attributes)
      {
        breed: attributes['name'],
        description: attributes['description'],
        life_span: attributes['life_span'],
        male_weight: attributes['male_weight'],
        female_weight: attributes['female_weight']
      }
    rescue StandardError => e
      Rails.logger.error "Error parsing breed info: #{e.message}"
      nil
    end
  end
end
