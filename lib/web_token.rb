class WebToken
  def self.encode(id)
    JWT.encode(id, Rails.application.secrets.secret_key_base)
  end

  def self.decode(sha)
    a = JWT.decode(sha, Rails.application.secrets.secret_key_base)
    require 'pry'; binding.pry
  end
end
