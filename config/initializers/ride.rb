require 'redis'

redis = Redis.new(url: 'rediss://red-cp5nvsa1hbls73fj3ssg:9ocnNmDZK6fPz4UChUI3wfF8AukSP0oU@virginia-redis.render.com:6379', password: '9ocnNmDZK6fPz4UChUI3wfF8AukSP0oU')
puts redis.ping
