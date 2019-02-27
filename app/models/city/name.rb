class City::Name
  class << self

    def []=(name, id)
      redis.hset(:city_id, name, id)
    end

    def [](name)
      redis.hget(:city_id, name)
    end

    private

    def redis
      $redis
    end
  end
end
