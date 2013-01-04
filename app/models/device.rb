# Set of helper methods that make it easy to retrieve user devices from the
# redis store.
module Device
  def self.find(user_id)
    return $redis.smembers(key(user_id))
  end

  def self.register(user_id, reg_id)
    if reg_id.blank?
      return false
    else
      return $redis.sadd(key(user_id), reg_id)
    end
  end

  def self.unregister(user_id, reg_id)
    return $redis.srem(key(user_id), reg_id)
  end

  private
  def self.key(user_id)
    "devices:#{user_id}"
  end
end
