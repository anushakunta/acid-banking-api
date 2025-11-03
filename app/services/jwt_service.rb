require 'jwt'

class JwtService
  SECRET = ENV.fetch('JWT_SECRET', 'dev_secret_key')

  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET, 'HS256')
  end

  def self.decode(token)
    decoded = JWT.decode(token, SECRET, true, { algorithm: 'HS256' })
    decoded.first
  rescue
    nil
  end
end
