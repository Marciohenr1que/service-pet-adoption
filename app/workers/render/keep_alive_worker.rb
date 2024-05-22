module Render
class KeepAliveWorker
    include Sidekiq::Worker
  
    def perform
      response = Net::HTTP.get_response(URI('https://service-pet-adoption.onrender.com'))
      
    end
  end
end  