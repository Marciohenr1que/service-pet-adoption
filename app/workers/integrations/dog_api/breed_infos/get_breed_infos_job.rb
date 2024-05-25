require 'redis'

module Integrations
  module DogApi
    module BreedInfos
      class GetBreedInfosJob
        include Sidekiq::Worker
        
        def perform
          page = 1
          loop do
            url = "https://dogapi.dog/api/v2/breeds?page[number]=#{page}"
            uri = URI(url)
            response = Net::HTTP.get(uri)
            breeds = JSON.parse(response)['data']
      
            break if breeds.empty? # Sai do loop 
            
            breeds.each do |breed|
              name = breed['attributes']['name']
              description = breed['attributes']['description']
              
              existing_breed = Breed.find_by(name: name)
              if existing_breed
                existing_breed.update(description: description)
              else
                Breed.create(name: name, description: description)
              end
            end
            
            page += 1 
          end
        end
      end
    end
  end
end
