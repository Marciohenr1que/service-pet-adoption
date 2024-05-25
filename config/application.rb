require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module PetAdoption
  class Application < Rails::Application
    config.load_defaults 7.1

    # Load custom code from the lib directory
    config.autoload_paths << Rails.root.join('lib')

    # Load custom code from the app/repositories directory
  config.autoload_paths << Rails.root.join('app', 'repositories')
  config.autoload_paths += Dir[Rails.root.join('app', 'repositories', '**/')]
 

    # Configure Active Job to use Sidekiq as the queue adapter
    config.active_job.queue_adapter = :sidekiq

    # Configure Rails as an API-only application
    config.api_only = true
  end
end
