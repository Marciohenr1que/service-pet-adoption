
module Integrations
  module DogApi
    class BreedInfo
      def self.fetch_breeds
        Client.get("/api/v2/breeds")
      end
    end
  end
end
