class AuthenticateUser
  def initialize(email, password)
    @email = email
    @password = password
  end

  # Επιστρέφει το token αν τα credentials είναι έγκυρα
  def call
    JsonWebToken.encode(user_id: user.id) if user
  end

  private

  attr_reader :email, :password

  def user
    user = User.find_by(email: email)
    # Η μέθοδος authenticate παρέχεται από το has_secure_password
    return user if user && user.authenticate(password)
    # Αν αποτύχει, εγείρουμε σφάλμα αυθεντικοποίησης
    raise(ExceptionHandler::AuthenticationError, "Invalid credentials")
  end
end