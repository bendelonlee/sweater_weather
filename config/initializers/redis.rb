unless Rails.env.test?
  $redis = Redis::Namespace.new("my_app", :redis => Redis.new)
else
  $redis = Redis::Namespace.new(:sweater, redis: MockRedis.new )
end
