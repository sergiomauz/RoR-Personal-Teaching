class ApplicationController < ActionController::API
  helper_method :current_user
  helper_method :admin_permission?
  helper_method :return_error_message
  helper_method :verb_of_request

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

  def verb_of_request
    return 'GET' if request.get?
    return 'POST' if request.post?
    return 'PUT' if request.put?
    return 'PATCH' if request.patch?

    'DELETE'
  end

  def admin_permission?
    # We can use variables for getting permissions if it was necessary
    # In this case, if current user is admin, it has permission
    current_user.admin
  end
end
