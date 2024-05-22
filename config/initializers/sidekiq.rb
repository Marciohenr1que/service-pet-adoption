require 'sidekiq'
require 'sidekiq-cron'

Sidekiq.configure_server do |config|
  config.redis = { url: 'rediss://red-cp5nvsa1hbls73fj3ssg:9ocnNmDZK6fPz4UChUI3wfF8AukSP0oU@virginia-redis.render.com:6379' }
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'rediss://red-cp5nvsa1hbls73fj3ssg:9ocnNmDZK6fPz4UChUI3wfF8AukSP0oU@virginia-redis.render.com:6379' }
end

