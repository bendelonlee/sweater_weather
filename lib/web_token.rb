class WebToken
  class << self

    def encode(id)
      JWT.encode(payload(id), Rails.application.secrets.secret_key_base)
    end

    def payload(id)
      {
        exp: (Time.now.round(0) + 1.days).to_i,
        id: id
      }
    end

    def decode(sha)
      payload = decoded_playoad(sha)
      id = payload['id']
      if Time.strptime(payload['exp'].to_s, '%s') < Time.now
        :expired
      else
        id
      end
    end

    private

    def decoded_playoad(sha)
      JWT.decode(sha, Rails.application.secrets.secret_key_base)[0]
    end
  end
end
