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

  def get_verb
    return 'GET' if request.get?
    return 'POST' if request.post?
    return 'PUT' if request.put?
    return 'PATCH' if request.patch?
    'DELETE'
  end

  def has_admin_permission?
    # We can use variables for getting permissions if it was necessary
    # In this case, if current user is admin, it has permission
    current_user.admin
  end
end
