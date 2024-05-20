require 'sidekiq'


Sidekiq.configure_server do |config|
  config.redis = { url: 'rediss://red-cp4egei1hbls73f0gic0:XdtJb5cUIw2kQHtb0Hre6BlGutklcUC4@oregon-redis.render.com:6379' }
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'rediss://red-cp4egei1hbls73f0gic0:XdtJb5cUIw2kQHtb0Hre6BlGutklcUC4@oregon-redis.render.com:6379' }
end

