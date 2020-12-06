class ApplicationController < ActionController::API
  helper_method :current_user

  def current_user
    User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end

  def return_error_message(code)
    case code
    when 403
      'This resource is forbidden'
    else
      'Error'
    end
  end

  def has_permission(_action_url)
    controller_path
    # false if action_url.nil? || action_url.empty?
    # User.find(doorkeeper_token.resource_owner_id).admin if doorkeeper_token

    # false
  end
end
