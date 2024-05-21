module Integrations
  module DogApi
    class BreedInfoService
      def self.get_breed_info(breed_name)
        response = fetch_breeds
        breed = find_breed(response, breed_name)
        return {} unless breed

        Integrations::DogApi::BreedInfoHelper.parse_breed_info(breed['attributes'])
      end

      def self.fetch_breeds
        Integrations::DogApi::Client.get("/api/v2/breeds")
      end

      def self.find_breed(response, breed_name)
        breeds = JSON.parse(response.body)['data']
        breeds.find { |b| b['attributes']['name'].casecmp(breed_name).zero? }
      end
    end
  end
end
