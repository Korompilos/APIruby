class UsersController < ApplicationController
  skip_before_action :authorize_request, only: :create

  # POST /signup
  # Δημιουργεί νέο χρήστη και επιστρέφει το token του
  def create
    user = User.create!(user_params)
    auth_token = AuthenticateUser.new(user.email, user.password).call
    response = { message: "Account created successfully", auth_token: auth_token }
    json_response(response, :created)
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end