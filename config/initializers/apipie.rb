Apipie.configure do |config|
  config.app_name                = 'Backend Personal Teaching'
  config.app_info                = 'It is the documentation for the API of Backend Personal Teaching, for booking an appointment with a teacher.'  
  config.api_base_url            = '/api/v1'
  config.doc_base_url            = '/api/v1/doc'
  config.link_extension          = ''
  config.translate               = false
  config.validate                = false
  
  config.authenticate = Proc.new do    
    Rails.env.development? || authenticate_or_request_with_http_basic do |username, password|
      user = User.find_by(:username => username)
      if user && user.valid_password?(password)
        user.admin
      end
    end
  end

  # where is your API defined?
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/**/*.rb"
end
