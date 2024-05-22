module Render
class KeepAliveWorker
    include Sidekiq::Worker
  
    def perform
      response = Net::HTTP.get_response(URI('https://service-pet-adoption.onrender.com'))
      puts "KeepAliveWorker performed: #{response.code}"
    end
  end
end  