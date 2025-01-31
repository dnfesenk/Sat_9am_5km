RailsPerformance.setup do |config|
  config.enabled = ENV['RAILS_PERFORMANCE_ENABLED'] == 'true'

  redis = Redis.new host: ENV.fetch('REDIS_HOST', '127.0.0.1')
  config.redis = Redis::Namespace.new("#{Rails.env}-rails-performance", redis: redis)

  config.http_basic_authentication_enabled = false

  config.ignored_endpoints = [
    'RailsPerformance::RailsPerformanceController#index', 'RailsPerformance::RailsPerformanceController#custom',
    'RailsPerformance::RailsPerformanceController#recent', 'RailsPerformance::RailsPerformanceController#slow',
    'RailsPerformance::RailsPerformanceController#requests', 'RailsPerformance::RailsPerformanceController#rake',
    'RailsPerformance::RailsPerformanceController#crashes', 'RailsPerformance::RailsPerformanceController#trace',
    'RailsPerformance::RailsPerformanceController#sidekiq', 'RailsPerformance::RailsPerformanceController#summary'
  ]
end if defined?(RailsPerformance)
