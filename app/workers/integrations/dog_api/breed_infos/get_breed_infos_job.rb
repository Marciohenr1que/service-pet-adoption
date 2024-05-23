require 'redis'

module Integrations
  module DogApi
    module BreedInfos
      class GetBreedInfosJob
        include Sidekiq::Worker
        
        def perform(breed_name)
          # Busque as informações da raça
          breed_info = BreedInfoService.get_breed_info(breed_name)
        end
      end
    end
  end
end
