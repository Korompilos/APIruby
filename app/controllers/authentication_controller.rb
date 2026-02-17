class AuthenticationController < ApplicationController
  # Παρακάμπτουμε τον έλεγχο token για το login!
  skip_before_action :authorize_request, only: :authenticate

  # Επιστρέφει auth token μετά την επαλήθευση credentials
  def authenticate
    auth_token = AuthenticateUser.new(auth_params[:email], auth_params[:password]).call
    json_response(auth_token: auth_token)
  end

  def logout
    # Στο stateless JWT απλώς επιστρέφουμε επιτυχία.
    # Ο χρήστης "βγαίνει" διαγράφοντας το token από το Postman/Frontend.
    json_response({ message: "Logout successful" })
  end

  private

  def auth_params
    params.permit(:email, :password)
  end
end