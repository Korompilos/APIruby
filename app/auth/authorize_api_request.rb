class AuthorizeApiRequest
  def initialize(headers = {})
    @headers = headers
  end

  # Επιστρέφει τον χρήστη αν το αίτημα είναι έγκυρο
  def call
    { user: user }
  end

  private

  attr_reader :headers

  def user
    # Ελέγχει αν ο χρήστης υπάρχει στη βάση
    @user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token
  rescue ActiveRecord::RecordNotFound => e
    raise ExceptionHandler::InvalidToken, ("Invalid token #{e.message}")
  end

  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
  end

  def http_auth_header
    if headers['Authorization'].present?
      return headers['Authorization'].split(' ').last
    end
    raise(ExceptionHandler::MissingToken, "Missing token")
  end
end