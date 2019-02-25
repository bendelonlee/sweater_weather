class WebToken
  def self.encode(id)
    JWT.encode(payload(id), Rails.application.secrets.secret_key_base)
  end

  def self.payload(id)
    {
      exp: (Time.now.beginning_of_hour + 10.years).to_i,
      id: id
    }
  end

  def self.decode(sha)
    JWT.decode(sha, Rails.application.secrets.secret_key_base)[0]['id']
  end
end
