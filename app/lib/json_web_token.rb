class JsonWebToken
  # Μυστικό κλειδί για την υπογραφή των tokens
  HMAC_SECRET = Rails.application.secret_key_base

  def self.encode(payload, exp = 24.hours.from_now)
    # Ορισμός χρόνου λήξης (default 24 ώρες)
    payload[:exp] = exp.to_i
    # Υπογραφή του token
    JWT.encode(payload, HMAC_SECRET)
  end

  def self.decode(token)
    # Αποκωδικοποίηση του token
    body = JWT.decode(token, HMAC_SECRET)[0]
    HashWithIndifferentAccess.new body
    # Διαχείριση λαθών αν το token έχει λήξει ή είναι άκυρο
  rescue JWT::DecodeError => e
    raise ExceptionHandler::InvalidToken, e.message
  end
end