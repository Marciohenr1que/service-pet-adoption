module Integrations
  module OwnersIntegration
    class OwnerService
      def initialize(repository = OwnerRepository.new)
        @repository = repository
      end

      def fetch_all
        @repository.all
      end

      def find(id)
        @repository.find(id)
      end

      def create(params)
        owner = @repository.create(params)
        if owner.save
          { success: true, owner: owner }
        else
          { success: false, errors: owner.errors.full_messages }
        end
      end

      def update(owner, params)
        if @repository.update(owner, params)
          { success: true, owner: owner }
        else
          { success: false, errors: owner.errors.full_messages }
        end
      end
      def destroy(owner, params)
        if @repository.update(owner, params)
          { success: true, owner: owner }
        else
          { success: false, errors: owner.errors.full_messages }
        end
      end
    end
  end
end
