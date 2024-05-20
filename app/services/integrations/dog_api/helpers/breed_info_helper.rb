module Integrations
  module DogApi
  
      class BreedInfoHelper
        def self.parse_breed_info(attributes)
          {
            breed: attributes['name'],
            description: attributes['description'],
            life_span: "#{attributes['life']['min']} - #{attributes['life']['max']} years",
            male_weight: "#{attributes['male_weight']['min']} - #{attributes['male_weight']['max']} kg",
            female_weight: "#{attributes['female_weight']['min']} - #{attributes['female_weight']['max']} kg"
          }
        end
      end
    end
  end
end
