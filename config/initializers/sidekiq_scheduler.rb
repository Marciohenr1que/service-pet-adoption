Sidekiq.configure_server do |config|
  schedule_file = "config/sidekiq_schedule.yml"

  if File.exist?(schedule_file)
    Sidekiq::Scheduler.reload_schedule!
  end
end
