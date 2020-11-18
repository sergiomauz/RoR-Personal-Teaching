# frozen_string_literal: true

Doorkeeper.configure do
  orm :active_record
    
  resource_owner_from_credentials do |routes|  
    user = User.find_by(:username => params[:username])
    if user && user.valid_password?(params[:password])
      user
    end    
  end

  use_refresh_token

  grant_flows %w(password)

  access_token_expires_in 1.hours

  skip_authorization do
    true
  end
    
  api_only
  base_controller 'ActionController::API'
end
