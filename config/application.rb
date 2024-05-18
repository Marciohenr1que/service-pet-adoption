require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module PetAdoption
  class Application < Rails::Application
    config.load_defaults 7.1

    # Load custom code from the lib directory
    config.autoload_paths += %W(#{config.root}/lib)

    # Configure Active Job to use Sidekiq as the queue adapter
    config.active_job.queue_adapter = :sidekiq

    # Configure Rails as an API-only application
    config.api_only = true
  end
end
