class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler

  # Καλούμε την αυθεντικοποίηση σε κάθε action
  before_action :authorize_request
  attr_reader :current_user

  after_action :log_activity

  private

  def authorize_request
    @current_user = (AuthorizeApiRequest.new(request.headers).call)[:user]
  end

  def log_activity
    return unless current_user
    ActivityLog.create(
      user_id: current_user.id,
      action: request.method,
      path: request.fullpath
    )
  end
end