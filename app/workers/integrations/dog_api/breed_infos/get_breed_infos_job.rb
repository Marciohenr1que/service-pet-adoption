require 'redis'

module Integrations
  module DogApi
    module BreedInfos
      class GetBreedInfosJob
        include Sidekiq::Worker
        
        def perform(breed_name)
          # Encontre o animal com base no nome da raça
          pet = Pet.find_by(breed: breed_name)
          return unless pet

          # Obtenha as informações da raça
          breed_info = Integrations::DogApi::BreedInfoService.get_breed_info(breed_name)

          # Defina o método breed_info para o animal
          pet.define_singleton_method(:breed_info) { breed_info || {} }
        end
      end
    end
  end
end


